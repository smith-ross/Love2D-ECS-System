local connection = {}
connection.__index = connection

function connection.new(event, func)
	local new_connection = {}
	setmetatable(new_connection, connection)
	new_connection.event = event
	new_connection.func = func

	return new_connection
end

function connection:disconnect()
	for i, v in pairs(self.event.connections) do
		if v == self then table.remove(self.event.connections, i) end
	end
end

return connection