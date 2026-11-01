shader_type canvas_item;

uniform int color_levels : hint_range(2, 16) = 4;
uniform float dither_strength : hint_range(0.0, 1.0) = 1.0;

uniform sampler2D screen_texture
	: hint_screen_texture, filter_nearest;

float bayer4(vec2 p) {
	int x = int(mod(p.x, 4.0));
	int y = int(mod(p.y, 4.0));

	float matrix[16] = {
		0.0,  8.0,  2.0, 10.0,
		12.0, 4.0, 14.0,  6.0,
		3.0, 11.0,  1.0,  9.0,
		15.0, 7.0, 13.0,  5.0
	};

	return (matrix[y * 4 + x] + 0.5) / 16.0;
}

void fragment() {
	vec3 color = texture(
		screen_texture, SCREEN_UV
	).rgb;

	vec2 pixel_pos = floor(
		SCREEN_UV / SCREEN_PIXEL_SIZE
	);

	float threshold = bayer4(pixel_pos) - 0.5;
	color += threshold * dither_strength
		/ float(color_levels);

	color = floor(
		clamp(color, 0.0, 1.0)
		* float(color_levels - 1) + 0.5
	) / float(color_levels - 1);
	
	COLOR = vec4(color, 1.0);
}
