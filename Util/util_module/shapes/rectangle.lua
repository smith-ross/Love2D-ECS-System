local rectangle = {}
local shape = require("Util/util_module/shapes/shape")
local event = require("Util/util_module/event")
rectangle.__index = rectangle
setmetatable(rectangle, shape)

function rectangle.new(pos, size, ...)
	local new_rect = shape.new(pos, size, ...)
	setmetatable(new_rect, rectangle)
	
	new_rect.class = "rectangle"
	return new_rect
end

return rectangle