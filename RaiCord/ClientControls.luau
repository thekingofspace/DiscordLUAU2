local Enums = require("./Enum")
local Serde = require("@lune/serde")

return function(Settings, Client)
    local self = {}

    function self:SetStatus(Status: string, StatusType: Enums.Custom_Enum, ActivityType: Enums.Custom_Enum)

        local Packet = {
            op = 3,
            d = {
                since = os.time();

                activities = {
                    {
                        name = Status;
                        type = ActivityType.Value
                    }
                };

                status = StatusType.Name:lower();

                afk = false
            }
        }

        Client.Connection:send(Serde.encode("json", Packet))
    end

    self.MessageController = {
        
    }

    return self
end