local Signal = require("../VendorModules/Signal")

local ClassBuilder = require("../Util/ClassConstructor")

local Request = require("../Requets")

local SignalerTable = {
    OnReady = Signal:CreateSignal();

    Heartbeat = Signal:CreateSignal();

    OnStop = Signal:CreateSignal();

    OnMessage = Signal:CreateSignal();

    PresenceUpdated = Signal:CreateSignal();

    Undefined = Signal:CreateSignal()
}

local QueryTable = {
    ["ready"] = SignalerTable.OnReady;

    ["message_create"] = SignalerTable.OnMessage,

    ["presence_update"] = SignalerTable.PresenceUpdated
}

return setmetatable({}::typeof(SignalerTable), {
    __index = function(aray, Key:string)
        if SignalerTable[Key] then
            return SignalerTable[Key]
        elseif QueryTable[Key] then
            return QueryTable[Key]
        end
        return
    end
})