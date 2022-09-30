local module = {}

module.init = function()
	return {
		["component"] = require("Components/class/component");
		["collider"] = require("Components/class/collider");
		["rigidbody"] = require("Components/class/rigidbody")
	}
end

return module