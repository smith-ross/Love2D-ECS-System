local draw = {}
local util 

draw.rectangle = function(obj)
	if not util then util = require("Util/utils").init() end
	love.graphics.setColor(obj.r,obj.g,obj.b, obj.transparency)
	love.graphics.rectangle('fill', obj.position.x, obj.position.y, obj.size.x, obj.size.y)
end

draw.image = function(obj)
	if not util then util = require("Util/utils").init() end
	love.graphics.setColor(obj.r,obj.g,obj.b)
	local img_object = love.graphics.newImage(obj.texture)
	love.graphics.draw(img_object, obj.position.x, obj.position.y, 0, obj.size.x, obj.size.y)
end

return draw