local event = {}
local connection = require("Util/util_module/connection")
event.__index = event

function event.new(event_tag)
	local new_event = {}
	setmetatable(new_event, event)
	new_event.tag = event_tag
	new_event.connections = {}

	return new_event
end

function event:connect(func)
	local new_connection = connection.new(self, func)
	table.insert(self.connections, new_connection)

	return new_connection
end

function event:fire(...)
	for _, v in pairs(self.connections) do
		coroutine.wrap(v.func)(...)
	end
end

return event