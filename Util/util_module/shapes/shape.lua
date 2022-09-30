local shape = {}
local renderer = require("Renderer/render")
shape.__index = shape


function shape.new(pos, size, ...)
	local new_shape = {}
	setmetatable(new_shape, shape)
	new_shape.position = pos
	new_shape.size = size
	new_shape.r = ({...})[1] or 1
	new_shape.g = ({...})[2] or 1
	new_shape.b = ({...})[3] or 1
	new_shape.opacity = 1

	new_shape.components = {}

	return new_shape
end

function shape:add_component(component)
	component.parent = self
	table.insert(self.components, component)
	component:on_activate()
end

function shape:get_component(component_name)
	for _, component in pairs(self.components) do
		if component.name == component_name then
			return component
		end
	end
end

function shape:destroy()
	self = nil
end

function shape:render()
	renderer.add_object(self)
end

return shape