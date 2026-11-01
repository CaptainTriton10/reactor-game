shader_type spatial;

uniform sampler2D subpixel_tex : filter_linear, source_color;
uniform sampler2D display_tex : source_color;

uniform vec2 uv_scale;
uniform float brightness;

uniform bool pixel_enabled;

void fragment() {
	vec2 uv = UV.xy;
	ALBEDO = vec3(0.0, 0.0, 0.0);
	
	if (pixel_enabled) {
		EMISSION = (texture(subpixel_tex, uv * uv_scale).rgb + 0.2) * 
				   texture(display_tex, uv).rgb * 
				   brightness;
	} else {
		EMISSION = texture(display_tex, uv).rgb * 0.6 * brightness;
	}
	
}
