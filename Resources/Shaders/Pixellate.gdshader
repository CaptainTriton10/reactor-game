shader_type spatial;
render_mode cull_disabled;

uniform sampler2D albedo_tex : filter_nearest, source_color;
uniform sampler2D roughness_tex : filter_nearest, source_color;
uniform float metallic = 0.0;

uniform int quantise_steps = 12;

uniform ivec2 pixel_steps = ivec2(128, 128);
uniform bool enable_pixellation = false;

uniform vec2 uv_scale = vec2(1.0, 1.0);

float quantise(float x, int steps) {
	float step_size = 1.0 / float(steps);
	return round(x / step_size) * step_size;
}

vec3 quantise_vec3(vec3 input, int steps) {
	return vec3(
		quantise(input.x, steps), 
		quantise(input.y, steps), 
		quantise(input.z, steps)
	);
}

vec2 pixellate(vec2 uv) {
	return vec2(
		round(uv.x * float(pixel_steps.x)) / float(pixel_steps.x),
		round(uv.y * float(pixel_steps.y)) / float(pixel_steps.y)
	);
}

void fragment() {
	if (enable_pixellation) {
		ALBEDO = quantise_vec3(texture(albedo_tex, pixellate(UV) * uv_scale).rgb, quantise_steps);		
	} else {
		ALBEDO = quantise_vec3(texture(albedo_tex, UV * uv_scale).rgb, quantise_steps);
	}

	ROUGHNESS = texture(roughness_tex, pixellate(UV) * uv_scale).r;
	METALLIC = metallic;
}
