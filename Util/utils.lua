local utils = {

	init = function()
		return {
			["vect2"] = require("Util/util_module/vect2");
			["draw"] = require("Util/util_module/draw");
			["color3"] = require("Util/util_module/color3");

			shapes = {
				["rectangle"] = require("Util/util_module/shapes/rectangle");
				["shape"] = require("Util/util_module/shapes/shape");
				["image"] = require("Util/util_module/shapes/image")
			}
		}
	end
}

return utils