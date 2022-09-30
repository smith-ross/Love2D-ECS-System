local image = {}
local shape = require("Util/util_module/shapes/shape")
image.__index = image
setmetatable(image, shape)

function image.new(address, pos, size, ...)
	local new_img = shape.new(pos, size, ...)
	setmetatable(new_img, image)
	
	new_img.class = "image"
	new_img.texture = address
	
	return new_img
end

return image