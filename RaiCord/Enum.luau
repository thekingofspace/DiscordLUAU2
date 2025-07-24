export type Custom_Enum = {
    Value:any;

    ID:number;
    
    Category:string;
    
    Name:string
}


local StandardEnum = {
    __eq =  function(Aray, Value)
        return Aray.ID == Value.ID and  Aray.Category == Value.Category and Aray.Value == Value.Value
    end,
    
    __tostring = function(Aray)
        return `Enum.{Aray.Category}.{Aray.Name}`
    end,
}

local MainEnums = {
    Intents = {
        GUILDS = {
            Value = 1; -- (1 << 0)
            -- Events:
            -- GUILD_CREATE, GUILD_UPDATE, GUILD_DELETE
            -- GUILD_ROLE_CREATE, GUILD_ROLE_UPDATE, GUILD_ROLE_DELETE
            -- CHANNEL_CREATE, CHANNEL_UPDATE, CHANNEL_DELETE, CHANNEL_PINS_UPDATE
            -- THREAD_CREATE, THREAD_UPDATE, THREAD_DELETE, THREAD_LIST_SYNC
            -- THREAD_MEMBER_UPDATE, THREAD_MEMBERS_UPDATE *
            -- STAGE_INSTANCE_CREATE, STAGE_INSTANCE_UPDATE, STAGE_INSTANCE_DELETE
        } :: Custom_Enum;

        GUILD_MEMBERS = {
            Value = 2; -- (1 << 1)
            -- Events: GUILD_MEMBER_ADD, GUILD_MEMBER_UPDATE, GUILD_MEMBER_REMOVE, THREAD_MEMBERS_UPDATE *
        } :: Custom_Enum;

        GUILD_MODERATION = {
            Value = 4; -- (1 << 2)
            -- Events: GUILD_AUDIT_LOG_ENTRY_CREATE, GUILD_BAN_ADD, GUILD_BAN_REMOVE
        } :: Custom_Enum;

        GUILD_EXPRESSIONS = {
            Value = 8; -- (1 << 3)
            -- Events: GUILD_EMOJIS_UPDATE, GUILD_STICKERS_UPDATE
            -- GUILD_SOUNDBOARD_SOUND_CREATE/UPDATE/DELETE/SOUNDS_UPDATE
        } :: Custom_Enum;

        GUILD_INTEGRATIONS = {
            Value = 16; -- (1 << 4)
            -- Events: GUILD_INTEGRATIONS_UPDATE, INTEGRATION_CREATE/UPDATE/DELETE
        } :: Custom_Enum;

        GUILD_WEBHOOKS = {
            Value = 32; -- (1 << 5)
            -- Events: WEBHOOKS_UPDATE
        } :: Custom_Enum;

        GUILD_INVITES = {
            Value = 64; -- (1 << 6)
            -- Events: INVITE_CREATE, INVITE_DELETE
        } :: Custom_Enum;

        GUILD_VOICE_STATES = {
            Value = 128; -- (1 << 7)
            -- Events: VOICE_CHANNEL_EFFECT_SEND, VOICE_STATE_UPDATE
        } :: Custom_Enum;

        GUILD_PRESENCES = {
            Value = 256; -- (1 << 8)
            -- Events: PRESENCE_UPDATE
        } :: Custom_Enum;

        GUILD_MESSAGES = {
            Value = 512; -- (1 << 9)
            -- Events: MESSAGE_CREATE, MESSAGE_UPDATE, MESSAGE_DELETE, MESSAGE_DELETE_BULK
        } :: Custom_Enum;

        GUILD_MESSAGE_REACTIONS = {
            Value = 1024; -- (1 << 10)
            -- Events: MESSAGE_REACTION_ADD/REMOVE/REMOVE_ALL/REMOVE_EMOJI
        } :: Custom_Enum;

        GUILD_MESSAGE_TYPING = {
            Value = 2048; -- (1 << 11)
            -- Events: TYPING_START
        } :: Custom_Enum;

        DIRECT_MESSAGES = {
            Value = 4096; -- (1 << 12)
            -- Events: MESSAGE_CREATE, MESSAGE_UPDATE, MESSAGE_DELETE, CHANNEL_PINS_UPDATE
        } :: Custom_Enum;

        DIRECT_MESSAGE_REACTIONS = {
            Value = 8192; -- (1 << 13)
            -- Events: MESSAGE_REACTION_ADD/REMOVE/REMOVE_ALL/REMOVE_EMOJI
        } :: Custom_Enum;

        DIRECT_MESSAGE_TYPING = {
            Value = 16384; -- (1 << 14)
            -- Events: TYPING_START
        } :: Custom_Enum;

        MESSAGE_CONTENT = {
            Value = 32768; -- (1 << 15)
            -- Required to access message content in most MESSAGE_CREATE/UPDATE
        } :: Custom_Enum;

        GUILD_SCHEDULED_EVENTS = {
            Value = 65536; -- (1 << 16)
            -- Events: GUILD_SCHEDULED_EVENT_CREATE/UPDATE/DELETE/USER_ADD/USER_REMOVE
        } :: Custom_Enum;

        AUTO_MODERATION_CONFIGURATION = {
            Value = 1048576; -- (1 << 20)
            -- Events: AUTO_MODERATION_RULE_CREATE/UPDATE/DELETE
        } :: Custom_Enum;

        AUTO_MODERATION_EXECUTION = {
            Value = 2097152; -- (1 << 21)
            -- Events: AUTO_MODERATION_ACTION_EXECUTION
        } :: Custom_Enum;

        GUILD_MESSAGE_POLLS = {
            Value = 16777216; -- (1 << 24)
            -- Events: MESSAGE_POLL_VOTE_ADD, MESSAGE_POLL_VOTE_REMOVE
        } :: Custom_Enum;

        DIRECT_MESSAGE_POLLS = {
            Value = 33554432; -- (1 << 25)
            -- Events: MESSAGE_POLL_VOTE_ADD, MESSAGE_POLL_VOTE_REMOVE
        } :: Custom_Enum;

        ALL = {
            Value = 53608447; -- (1 << 25)
            -- Events: MESSAGE_POLL_VOTE_ADD, MESSAGE_POLL_VOTE_REMOVE
        } :: Custom_Enum;
    },

    Status = {
        online = {
            Value = 0;
        } :: Custom_Enum;

        dnd = {
            Value = 2;
        } :: Custom_Enum;
        
        idle = {
            Value = 3;
        } :: Custom_Enum;

        invisible = {
            Value = 4;
        } :: Custom_Enum;

    };

    MessageFlags = {
        Crossposted = {
            Value = 1; -- 1 << 0
        } :: Custom_Enum;

        IsCrosspost = {
            Value = 2; -- 1 << 1
        } :: Custom_Enum;

        SuppressEmbeds = {
            Value = 4; -- 1 << 2
        } :: Custom_Enum;

        SourceMessageDeleted = {
            Value = 8; -- 1 << 3
        } :: Custom_Enum;

        Urgent = {
            Value = 16; -- 1 << 4
        } :: Custom_Enum;

        HasThread = {
            Value = 32; -- 1 << 5
        } :: Custom_Enum;

        Ephemeral = {
            Value = 64; -- 1 << 6
        } :: Custom_Enum;

        Loading = {
            Value = 128; -- 1 << 7
        } :: Custom_Enum;

        FailedToMentionSomeRolesInThread = {
            Value = 256; -- 1 << 8
        } :: Custom_Enum;

        SuppressNotifications = {
            Value = 4096; -- 1 << 12
        } :: Custom_Enum;

        IsVoiceMessage = {
            Value = 8192; -- 1 << 13
        } :: Custom_Enum;
    };

    ActivityType = {
        Playing = {
            Value = 0;
        } :: Custom_Enum;

        Streaming = {
            Value = 1;
        } :: Custom_Enum;

        Listening = {
            Value = 2;
        } :: Custom_Enum;

        Watching = {
            Value = 3;
        } :: Custom_Enum;

        Custom = {
            Value = 4;
        } :: Custom_Enum;

        Competing = {
            Value = 5;
        } :: Custom_Enum;
    };

}

for I, item in pairs(MainEnums) do
    local Count = 0
    for E, Enumerator in pairs(item) do
        Count+=1
        
        if Enumerator.ID == nil then
            Enumerator.ID = Count
        end
        
        Enumerator.Category = I
        
        Enumerator.Name = E
        
        MainEnums[I][E] = setmetatable(Enumerator, StandardEnum)
    end
end

return MainEnums