-- THIS SCRIPT SERVES AS AN EXAMPLE ON HOW THE PROGRAM COULD THEORETICALLY BE USED, BUT NOTHING MORE THAN THAT!
-- As such, this is a very fundamental example that shows a basic setup of how one could use this.

local util = require("Util/utils").init()
local component = require("Components/component_sys").init()
local renderer = require("Renderer/render")
local layers = require("layers")
local camera = require("Camera/camera")

for i, v in pairs(util) do
	getfenv()[i] = v -- create utils
end


-- create layers
local default_layer = layers.create_new(0)
local ground_layer = layers.create_new(1)

-- create camera
local main_camera = camera.new()

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local speed = 400
local dir_x = 0
local dir_y = 0

-- define our initial player entity
local player = shapes.rectangle.new(
	vect2.new(),
	vect2.new(100, 100),
	color3.from_rgb(255, 255, 255)
)

-- we'll use this obj to showcase collision detection
local obj = shapes.rectangle.new(
	vect2.new(400, 400),
	vect2.new(100, 100),
	color3.from_rgb(255,0,0)
)


local ground = shapes.rectangle.new(
	vect2.new(0, 500),
	vect2.new(800, 100),
	color3.from_rgb(100, 0, 0)
)

-- add our newly created objects to the layers we made earlier
default_layer:add_object(obj)
ground_layer:add_object(ground)

-- create our foreground, and initialising it with our player object
local foreground_layer = layers.create_new(2, nil, player)


love.window.setTitle("Engine")

-- since this uses a somewhat ECS-style, we can add colliders and rigidbodies to our player
player:add_component(component.collider.new("square"))
player:add_component(component.rigidbody.new())

-- our other objects are gonna need square colliders too
obj:add_component(component.collider.new("square"))
ground:add_component(component.collider.new("square"))

-- set our ground layer
ground_layer:set_ground_layer()

function love.load()
	local collision_component = obj:get_component("collider")
	
	collision_component.TouchEnter:connect(function(collider) -- event that is fired when obj is touched
			if collider == player then
					obj.r = 0
					obj.g = 255
					obj.b = 0
			end
	end)

	collision_component.TouchExit:connect(function(collider)-- event that is fired when obj is no longer touched
			if collider == player then
				obj.r = 255
				obj.g = 0
				obj.b = 0
			end
	end)
	
end

function love.update(delta_time) -- every frame
	_G.delta_time = delta_time -- update our dT for this frame
	
	player.position = vect2.new(player.position.x + (dir_x * (delta_time * speed)), player.position.y + (dir_y * (delta_time * speed))) -- update player position for smooth movement
end

function love.draw()
	main_camera:enable() -- enable the camera
	renderer:render() -- tell the renderer to render
	main_camera:set_position(( player.position - vect2.new(width/2, height / 2) ) +  vect2.new(player.size.x / 2, player.size.y / 2)) -- update cam position to follow player
	main_camera:disable() -- tell the camera we're not gonna edit it anymore this frame
end


-- below is things to handle player movement

function love.keypressed(key)
	dir_x = key == "d" and 1 or (key == "a" and -1 or dir_x)
	dir_y = key == "w" and -1 or (dir_y)
end

local opps_x = {
	["d"] = {"a", -1};
	["a"] = {"d", 1};
}
local opps_y = {
	["w"] = {"s", 1};
}

function love.keyreleased(key)
	if opps_x[key] then
		dir_x = (love.keyboard.isDown(opps_x[key][1]) and opps_x[key][2] or 0)
	elseif opps_y[key] then
		dir_y = 0
	end
end