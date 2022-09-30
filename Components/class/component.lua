local component = {}
component.__index = component

function component.new(component_data_arr)
	local new_component = {}
	setmetatable(new_component, component)

	new_component.parent = nil
	new_component.data = component_data_arr
	return new_component
end

return component