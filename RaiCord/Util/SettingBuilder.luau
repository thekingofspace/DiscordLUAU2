local module = {}

local Enum = require("../Enum")

function module.New(Token:string, Enums:{Enum.Custom_Enum})
    local NewSettings = {Token = Token, Enums = Enums}

    function NewSettings:Build()
        local FinalCount = 0
        for I, item in ipairs(NewSettings.Enums) do
            FinalCount+=item.Value
        end

        return FinalCount
    end

    return NewSettings
end

return module