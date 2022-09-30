local layers = {}
layers.__index = layers
local priority_layer
local active_layers = {}

--object
function layers.create_new(layer_id, visible, ...)
	local new_layer = {}
	setmetatable(new_layer, layers)

	new_layer.id = layer_id or #active_layers + 1
	new_layer.visible = visible or true
	new_layer.contents = (... and {...} or { })

	active_layers[layer_id] = new_layer

	return new_layer
end

function layers:set_priority()
	priority_layer = self
end

function layers:get_priority()
	return priority_layer
end

function layers:get_tag()
	return self.tag
end

function layers:set_ground_layer()
	self.tag = "ground"
end

function layers:get_ground_layer()
	for _, v in pairs(active_layers) do
		if v:get_tag() == "ground" then return v end
	end
end

function layers:add_object(object)
	table.insert(self.contents, object)
end

function layers:swap_order(other_layer)
	local other_layer_obj = active_layers[other_layer]
	active_layers[self.id] = other_layer
	active_layers[other_layer] = self
end

--statics

function layers.get_layers()
	return active_layers
end



return layers
