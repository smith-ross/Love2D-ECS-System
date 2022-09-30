local vect2 = {}
local util

vect2.__index = vect2
vect2.__add = function(table, value)
	return vect2.new((table.x + value.x), (table.y + value.y))
end
vect2.__sub = function(table, value)
	return vect2.new((table.x - value.x), (table.y - value.y))
end
vect2.__mul = function(table, value)
	if type(value) ~= "table" then value = vect2.new(value, value) end 
	return vect2.new((table.x * value.x), (table.y * value.y))
end
vect2.__div = function(table, value)
	if type(value) ~= "table" then value = vect2.new(value, value) end 
	return vect2.new((table.x / value.x), (table.y / value.y))
end
vect2.__tostring = function(table)
	return "(" .. table.x .. ", " .. table.y .. ")"
end

function vect2.new(x, y)
	if not util then util = require("Util/utils").init() end
	local new_vect2 = {}
	setmetatable(new_vect2, vect2)
	new_vect2.x = x or 0
	new_vect2.y = y or 0
	return new_vect2
end

function vect2:zero()
	self.x = 0 
	self.y = 0
end

return vect2