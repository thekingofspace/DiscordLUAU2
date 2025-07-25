local ClassBuilder = require("../Util/ClassConstructor")

return function(self, Events:typeof(require("./Events")))
    Events.PresenceUpdated:AddConstructor(function(Data)
        return ClassBuilder.CreateUser(self.Requests.GetUserInfo(Data.user.id)), Data
    end)

    Events.OnMessage:AddConstructor(function(Data)
        return ClassBuilder.CreateMessage(Data), ClassBuilder.CreateUser(Data.author), Data.channel_id, Data
    end)

    Events.OnReady:AddConstructor(function(Data)
        self.User = self.Requests.GetUserInfo(Data.user.id)
        return self.User, Data
    end)
end