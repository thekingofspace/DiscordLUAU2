local EndPoint = "https://discord.com/api/v10"
local Net = require("@lune/net")
local Serde = require("@lune/serde")

local ClassBuilder = require("./Util/ClassConstructor")

local module = {}

module.Token = ""

function module.GetUserInfo(User:string)
    local Data = Serde.decode("json", Net.request({
        url = EndPoint .. "/users/" .. User,
        method = "GET",
        headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = module.Token
        },
    }).body)

    return ClassBuilder.CreateUser(Data)
end

function module:SendMessage(Channel:string, Payload)
    local Data = Serde.decode("json", Net.request({
        url = EndPoint .. `/channels/{Channel}/messages`,
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = module.Token
        },
        body = Serde.encode("json", Payload)
    }).body)

    return ClassBuilder.CreateUser(Data)
end

return module
