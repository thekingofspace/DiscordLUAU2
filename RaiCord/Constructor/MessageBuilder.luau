local MessageBuilder = {}
MessageBuilder.__index = MessageBuilder

function MessageBuilder.new()
	local self = setmetatable({}, MessageBuilder)

	self.payload = {
		content = "",
		embeds = {},
		components = {},
		tts = false,
		flags = 0,
		allowed_mentions = {
			parse = { "users", "roles", "everyone" },
		},
	}

	return self
end

function MessageBuilder:setContent(text: string)
	self.payload.content = text
	return self
end

function MessageBuilder:setTTS(enabled: boolean)
	self.payload.tts = enabled
	return self
end

function MessageBuilder:setFlags(flags: number)
	self.payload.flags = flags
	return self
end

function MessageBuilder:addEmbed(embed: {})
	table.insert(self.payload.embeds, embed)
	return self
end

function MessageBuilder:addComponent(component: {})
	table.insert(self.payload.components, component)
	return self
end

function MessageBuilder:addComponents(components: { {} })
	for _, c in ipairs(components) do
		table.insert(self.payload.components, c)
	end
	return self
end

function MessageBuilder:setPayload(payload: {})
	self.payload = payload
	return self
end

function MessageBuilder:replyTo(messageId: string, shouldPing: boolean?)
	self.payload.message_reference = {
		message_id = messageId,
		fail_if_not_exists = false,
	}

	if shouldPing == false then
		self.payload.allowed_mentions = {
			replied_user = false
		}
	elseif shouldPing == true then
		self.payload.allowed_mentions = {
			replied_user = true
		}
	end

	return self
end

function MessageBuilder:build(): {}
	return self.payload
end

return MessageBuilder
