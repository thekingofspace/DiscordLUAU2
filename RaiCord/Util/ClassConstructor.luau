local module = {}

function GetMimeCategory(mime:string)
    return mime:match("^(.-)/")
end


function module.CreateFile(Data)
    return {
        Type = GetMimeCategory(Data.content_type);

        FileName = Data.filename;

        Meta = {
            id = Data.id;

            url = Data.url;

            placeholder = Data.placeholder
        };

        Proxy = Data.proxy_url
    }
end

function module.CreateMessage(Data)
    return {
        Content = Data.content;

        Time = Data.timestamp;

        Type = Data.type;

        pinned = Data.pinned;

        ID = Data.id;

        components = Data.components;

        Pings = Data.mentions;

        Roles_Pinged = Data.mention_roles;

        Everyone = Data.mention_everyone;

        Files = (function()
            local Items = {}

            for I, item in ipairs(Data.attachments) do
                table.insert(Items, module.CreateFile(item))
            end

            return Items
        end)()
    }
end

function module.CreateUser(Data)
    return {
        Username = Data.username or Data.Username or "";
        Display_Name = Data.global_name or Data.Display_Name or Data.username or Data.Username or "";
        UserId = Data.id or Data.UserId or "";
        Discriminator = Data.discriminator or Data.Discriminator or "";
        bot = (Data.bot == true);

        ColorData = {
            Accent = Data.accent_color or (Data.ColorData and Data.ColorData.Accent) or 0;
            Banner_Color = Data.banner_color or (Data.ColorData and Data.ColorData.Banner_Color) or 0;
        };

        ImageData = {
            Avatar = Data.avatar or (Data.ImageData and Data.ImageData.Avatar) or "";
            Banner = Data.banner or (Data.ImageData and Data.ImageData.Banner) or "";
        };
    }
end


return module