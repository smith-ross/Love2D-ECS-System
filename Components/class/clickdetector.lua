local clickdetector = {}
local util = require("Util/utils").init()
local event = require("Util/util_module/event")
local layers = require("layers")
local component = require("Components/class/component")
clickdetector.__index = clickdetector
setmetatable(clickdetector, component)

function clickdetector.new(gravity, position, size, auto_scale, ...)
	local new_click	= component.new(...)
	setmetatable(new_click, clickdetector)

	new_click.position = position or util.vect2.new()
	new_click.size = size or util.vect2.new()
	new_click.auto_scale = auto_scale or true

	new_click.name = "click_detector"
	
	new_click.MouseButton1Down = event.new("mouseButton1Down")
	new_click.MouseButton1Up = event.new("mouseButton1Up")
	new_click.MouseButton2Down = event.new("mouseButton2Down")
	new_click.MouseButton2Up = event.new("mouseButton2Up")
	
	new_click.MouseEnter = event.new("mouseEnter")
	new_click.MouseExit = event.new("mouseExit")

	return new_click

end


function clickdetector:on_update()
	
end

return clickdetector