local Types = require("@self/Types")

type Custom_Enum = {
    Value:any;

    ID:number;
    
    Category:string;
    
    Name:string
}

export type Message = Types.Message

export type file = Types.File

export type User = Types.User


return {
    Client = require("@self/Constructor/Client");

    SettingsBuilder = require("@self/Util/SettingBuilder");

    Vendors = {
        Signal = require("@self/VendorModules/Signal")
    };
    Enum = require("@self/Enum");

    EmbedBuilder = require("@self/Constructor/EmbedBuilder");

    MessageBuilder = require("@self/Constructor/MessageBuilder");

    ClassConstructor = require("@self/Util/ClassConstructor")
}