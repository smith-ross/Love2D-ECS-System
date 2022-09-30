local color3 = {}

function color3.from_rgb(r, g, b)
	return r/255, g/255, b/255
end

function color3.new(r, g, b)
	return r, g, b
end

return color3