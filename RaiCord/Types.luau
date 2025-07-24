type FileMeta = {
    id: string,
    url: string,
    placeholder: boolean
}

export type File = {
    Type: string,
    FileName: string,
    Meta: FileMeta,
    Proxy: string
}

export type Message = {
    Content: string,
    Time: string,
    Type: number,
    pinned: boolean,
    ID: string,
    components: any,
    Pings: { [number]: any },
    Roles_Pinged: { [number]: string },
    Everyone: boolean;
    Files:{File}
}

type ColorData = {
    Accent: number?,
    Banner_Color: number?
}

type ImageData = {
    Avatar: string?,
    Banner: string?
}

export type User = {
    Username: string,
    Display_Name: string?,
    UserId: string | number,
    Discriminator: string,
    bot: boolean,
    ColorData: ColorData,
    ImageData: ImageData
}

return {}