local camera = {}
local util = require("Util/utils").init()
camera.__index = camera

function camera.new()
	local new_camera = {}
	setmetatable(new_camera, camera)
	new_camera.position = util.vect2.new()
	new_camera.scale = util.vect2.new(1, 1)
	new_camera.rotation = 0

	return new_camera
end

function camera:enable()
	love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.scale.x, 1 / self.scale.y)
  love.graphics.translate(-self.position.x, -self.position.y)
end

function camera:disable()
	love.graphics.pop()
end

function camera:zoom(zoom_amount)
	self.scale = util.vect2.new(zoom_amount, zoom_amount)
end

function camera:set_position(position)
	self.position = position
end

function camera:set_rotation(rotation)
	self.rotation = rotation
end

return camera