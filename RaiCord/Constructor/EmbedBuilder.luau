local EmbedBuilder = {}
EmbedBuilder.__index = EmbedBuilder

export type Embed = {
	title: string?,
	description: string?,
	color: number?,
	timestamp: string?,
	fields: { { name: string, value: string, inline: boolean? } },
	footer: { text: string, icon_url: string? }?,
	author: { name: string, icon_url: string?, url: string? }?,
	image: { url: string }?,
	thumbnail: { url: string }?,
}

local function hexToDecimal(hex: string): number
	-- Accepts "#RRGGBB" or "RRGGBB" format
	hex = hex:gsub("#", "")
	assert(#hex == 6, "Hex color must be 6 characters")
	local r = tonumber(hex:sub(1,2), 16)
	local g = tonumber(hex:sub(3,4), 16)
	local b = tonumber(hex:sub(5,6), 16)
	assert(r and g and b, "Invalid hex color")
	return r * 65536 + g * 256 + b
end

function EmbedBuilder.new()
	local self = setmetatable({}, EmbedBuilder)
	self.Embed = {
		Fields = {},
	}
	return self
end

function EmbedBuilder:SetTitle(title: string)
	self.Embed.Title = title
	return self
end

function EmbedBuilder:SetDescription(desc: string)
	self.Embed.Description = desc
	return self
end

function EmbedBuilder:SetColor(color: Color3 | string)
	-- Accept Color3 or hex string "#RRGGBB"
	if typeof(color) == "Color3" then
		local r = math.floor(color.R * 255)
		local g = math.floor(color.G * 255)
		local b = math.floor(color.B * 255)
		self.Embed.Color = r * 65536 + g * 256 + b
	elseif type(color) == "string" then
		self.Embed.Color = hexToDecimal(color)
	else
		error("SetColor expects a Color3 or hex string like '#7289da'")
	end
	return self
end

function EmbedBuilder:SetTimestamp(isoTimestamp: string?)
	self.Embed.Timestamp = isoTimestamp or DateTime.now():ToIsoDate()
	return self
end

function EmbedBuilder:AddField(name: string, value: string, inline: boolean?)
	table.insert(self.Embed.Fields, {
		name = name,
		value = value,
		inline = inline or false,
	})
	return self
end

function EmbedBuilder:SetFooter(text: string, icon_url: string?)
	self.Embed.Footer = {
		text = text,
		icon_url = icon_url,
	}
	return self
end

function EmbedBuilder:SetAuthor(name: string, icon_url: string?, url: string?)
	self.Embed.Author = {
		name = name,
		icon_url = icon_url,
		url = url,
	}
	return self
end

function EmbedBuilder:SetImage(url: string)
	self.Embed.Image = { url = url }
	return self
end

function EmbedBuilder:SetThumbnail(url: string)
	self.Embed.Thumbnail = { url = url }
	return self
end

function EmbedBuilder:Build(): Embed
	-- Convert all keys to lowercase to match Discord API
	local embed = {}

	if self.Embed.Title then
		embed.title = self.Embed.Title
	end
	if self.Embed.Description then
		embed.description = self.Embed.Description
	end
	if self.Embed.Color then
		embed.color = self.Embed.Color
	end
	if self.Embed.Timestamp then
		embed.timestamp = self.Embed.Timestamp
	end

	embed.fields = self.Embed.Fields or {}

	if self.Embed.Footer then
		embed.footer = self.Embed.Footer
	end
	if self.Embed.Author then
		embed.author = self.Embed.Author
	end
	if self.Embed.Image then
		embed.image = self.Embed.Image
	end
	if self.Embed.Thumbnail then
		embed.thumbnail = self.Embed.Thumbnail
	end

	return embed
end

return EmbedBuilder
