local renderer = {}
local shapes = {}
local util
local layers = require("layers")

function renderer.add_object(object)
	table.insert(shapes, object)
end

function renderer:render()
	if not util then util = require("Util/utils").init() end
	if layers:get_priority() ~= nil then
		for _, obj in pairs(layers:get_priority().contents) do
			util["draw"][obj.class](obj)
			for _, component in pairs(obj.components) do
				if component.on_update then component:on_update(_G.delta_time) end
			end
		end
	end
	for _, layer in pairs(layers.get_layers()) do
		if layer ~= layers:get_priority() then
			for _, obj in pairs(layer.contents) do
				util["draw"][obj.class](obj)
				for _, component in pairs(obj.components) do
					if component.on_update then component:on_update(_G.delta_time) end
				end
			end
		end
	end
end

return renderer