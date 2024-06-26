shader_type canvas_item;

uniform vec4 origin_color1 : source_color;
uniform vec4 origin_color2 : source_color;

uniform vec4 new_color1 : source_color;
uniform vec4 new_color2 : source_color;

bool colorMatch(vec4 c1, vec4 c2, float maxDiff) {
	return (
		abs(c1.r - c2.r) < maxDiff
		&& abs(c1.g - c2.g) < maxDiff
		&& abs(c1.b - c2.b) < maxDiff
	);
}

void fragment() {
	vec4 current_pixel = texture(TEXTURE, UV);
	
	if (colorMatch(current_pixel, origin_color1, 0.01))
		COLOR = new_color1;
	else if (colorMatch(current_pixel, origin_color2, 0.01))
		COLOR = new_color2;
	else
		COLOR = current_pixel;
}
