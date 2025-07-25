local Gateway = "wss://gateway.discord.gg/?v=10&encoding=json"

local Net = require("@lune/net")

local Events = require("./Events")

local task = require("@lune/task")

local Serde = require("@lune/serde")

local RequestHandler = require("../Requets")

local Types = require("../Types")

local ClientControls = require("../ClientControls")

local EventBuilder = require("./ClientEventBuilder")

local ClientHandler = {}

ClientHandler.Requests = RequestHandler

function ClientHandler.New(ClientSettings)
    local self = setmetatable({}, {});
    local Connection:Net.WebSocket = nil
    self.Events = Events
    self.Heartbeat = nil
    self.Alive = nil
    local IsStarted = false
    self.Debug = false
    self.Requests = RequestHandler;
    self.User = nil::Types.User?
    self.Connection = Connection

    self.ClientControls = ClientControls(ClientSettings, self)

    local Identifier = {
        op = 2;

        d = {
            token = ClientSettings.Token;

            intents = ClientSettings:Build();

            properties = {
                os = "linux";

                browser = "raithon";

                device = "raithon"
            }
        }
    }



    function self:Start()
        if IsStarted == true then
            error("Client is already running.")
        end

        EventBuilder(self, self.Events)

        if self.Debug == true then
            print("DEBUG MODE IS ACTIVE YOU WILL GET ALOT MORE MESSAGES THEN NORMAL.")
        end

        RequestHandler.Token = "Bot " .. Identifier.d.token

        IsStarted = true
        Connection = Net.socket(Gateway)

        Connection:send(Serde.encode("json", Identifier))

        self.Connection = Connection

        local Pack = Connection:next()
        Pack = Serde.decode("json", Pack)
        local Heartbeat:number = Pack.d.heartbeat_interval / 1000

        self.Heartbeat = task.spawn(function()
                while true do
                    task.wait(Heartbeat)
                    local heartbeatPayload = {
                        op = 1,
                        d = nil
                    }
                Connection:send(Serde.encode("json", heartbeatPayload))
                Events.Heartbeat:Fire()
            end
        end)

        self.Alive = task.spawn(function()
            while true do
                local Data = Connection:next()

                if not Data then
                    return
                end

                Data = Serde.decode("json", Data)

                if self.Debug == true and not Events[Data.t:lower()] then
                    print("")
                    print("------ DEBUG EVENT ------")
                    print("")
                    print(Data.t)

                    print("")

                    print(Data.d)
                end

                if Events[Data.t:lower()] then

                    if Events[Data.t:lower()].WasConnected == true then
                            Events[Data.t:lower()]:Fire(Data.d)
                    end

                    else

                    Events.Undefined:Fire(Data.t, Data.d)
                end
            end
        end)
    end

    function self:Stop()
        if IsStarted == false then
            error("Client is not running.")
        end

        IsStarted = false
        if Connection then
            Connection:close(1000)
        end

        if self.Heartbeat then
            task.cancel(self.Heartbeat)
        end

        if self.Alive then
            task.cancel(self.Alive)
        end

        Events.OnStop:Fire()
    end

    self.__index = self

    return self
end

return ClientHandler