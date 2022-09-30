local collider = {}
local component = require("Components/class/component")
local event = require("Util/util_module/event")
local util = require("Util/utils").init()
collider.__index = collider
setmetatable(collider, component)

function table.find(table, obj)
	for i, v in pairs(table) do
		if v == obj then return i end
	end
	return false
end

local active_colliders = {}

function collider.new(type, position, size, auto_scale, ...)
	local new_collider = component.new(...)
	setmetatable(new_collider, collider)
	new_collider.type = type
	new_collider.position = position or util.vect2.new()
	new_collider.size = size or util.vect2.new()
	new_collider.auto_scale = auto_scale or true
	new_collider.name = "collider"

	new_collider.TouchedPreviously = {}
	new_collider.TouchEnter = event.new("Touched")
	new_collider.TouchExit = event.new("LeftTouch")

	return new_collider
end

function collider:on_activate()
	table.insert(active_colliders, self)
end

function collider:on_update()
	if self.parent.class == "image" then
		self.size = self.auto_scale and util.vect2.new(love.graphics.newImage(self.parent.texture):getWidth(), love.graphics.newImage(self.parent.texture):getHeight()) or self.size
		self.position = self.parent.position
	else
		self.size = self.auto_scale and self.parent.size or self.size
		self.position = self.parent.position
	end

	for i, v in pairs(active_colliders) do
		if self:check_collision(v) == true then
			table.insert(self.TouchedPreviously, v)
			self.TouchEnter:fire(v.parent)
		elseif table.find(self.TouchedPreviously, v) ~= false then
			table.remove(self.TouchedPreviously, table.find(self.TouchedPreviously, v))
			self.TouchExit:fire(v.parent)
		end
	end

end

function collider:get_bounds()
	return
	{
		self.position,
		self.position + util.vect2.new(self.size.x, 0),
		self.position + util.vect2.new(0, self.size.y),
	}
end

function collider:check_collision(collider_object)
	if collider_object then
		local bounds = self:get_bounds()
		return
			self.position.x < collider_object.position.x + collider_object.size.x and
			collider_object.position.x < self.position.x + self.size.x and
			self.position.y < collider_object.position.y + collider_object.size.y and
			collider_object.position.y < self.position.y + self.size.y
	end
end



return collider