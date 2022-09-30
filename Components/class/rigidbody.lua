local rigidbody = {}
local util = require("Util/utils").init()
local layers = require("layers")
local component = require("Components/class/component")
rigidbody.__index = rigidbody
setmetatable(rigidbody, component)

function rigidbody.new(gravity, position, size, auto_scale, ...)
	local new_rb = component.new(...)
	setmetatable(new_rb, rigidbody)

	new_rb.position = position or util.vect2.new()
	new_rb.size = size or util.vect2.new()
	new_rb.auto_scale = auto_scale or true
	new_rb.gravity = gravity or 9.81
	new_rb.descending_time = 0
	new_rb.falling = false

	new_rb.name = "rigidbody"

	return new_rb

end

function rigidbody:check_grounded()
	local collider = self.parent:get_component("collider")
	local layers_array = layers.get_layers()
	if collider then
		if layers:get_ground_layer() then
			for  _, ground_obj in pairs(layers:get_ground_layer().contents) do
				if collider:check_collision(ground_obj) then
					return true
				end
			end
		end
	end
	return false
end

function rigidbody:on_activate()

end

function rigidbody:on_update()
	local dt = _G.delta_time
	local collider = self.parent:get_component("collider")
	if self.falling == true and self:check_grounded() == false then
		self.descending_time = self.descending_time + dt
		local speed = self.descending_time * self.gravity
		self.parent.position = self.parent.position + util.vect2.new(0, speed)
	elseif collider then
		local grounded = self:check_grounded()
		if grounded then
			self.falling = false
			self.descending_time = 0
		else
			self.falling = true
		end
	end
end

return rigidbody