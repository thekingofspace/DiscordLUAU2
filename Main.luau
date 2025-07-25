local Raicord = require('./RaiCord')
local Serde = require("@lune/serde")
local FS = require("@lune/fs")
local BotInfo:{Token:string} = Serde.decode("json", FS.readFile("./BotInfo.json"))
local task = require("@lune/task")

local Enumerator = Raicord.Enum

local Intents = Enumerator.Intents

local Settings = Raicord.SettingsBuilder.New(BotInfo.Token, {Intents.ALL})

local Client = Raicord.Client.New(Settings)

local Embed = Raicord.EmbedBuilder.new()
    :SetColor("#7289da")
    :SetTitle("Test")
    :SetDescription("Test")
    

    

Client.Debug = false

Client.Events.OnReady:Connect(function(Data)
    while not Client.User do
        task.wait()
    end
    print(Client.User.Display_Name, "Is online!")
    Client.ClientControls:SetStatus("Sup", Enumerator.Status.online, Enumerator.ActivityType.Playing)
end)

Client.Events.Heartbeat:ConnectAsync(function()
    print("ran")
end)

Client.Events.Heartbeat:Connect(function()
    print("ran 2")
end)

Client.Events.OnStop:Connect(function()
    print("Client closed")
end)

Client.Events.OnMessage:Connect(function(Message:Raicord.Message, Author:Raicord.User, Channel:string, Data)
    if Author.UserId == Client.User.UserId then
        return
    end

    local Args = Message.Content:split(" ")
    print(Author.Username, "#", Author.Discriminator)

    if Args[1]:lower() == "!test" then
        print(Args[2])
    end

    local newMessage = Raicord.MessageBuilder.new()
        :replyTo(Message.ID, true)
        :setContent("HI")
        :addEmbed(Embed:Build())

        print(Serde.encode("json", newMessage:build(), true))

    Client.Requests:SendMessage(Channel, newMessage:build())
end)

Client.Events.Undefined:Connect(function(Event:string, Data)
    FS.writeFile("./Storage/" .. Event .. ".json", Serde.encode("json", Data, true))
end)

Client:Start()
