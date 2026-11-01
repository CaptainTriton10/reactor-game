shader_type spatial;

void vertex() {
	
}

void fragment() {
	ALBEDO = vec3(0.1, 0.2, 0.4);
	ALPHA = 0.3;
	METALLIC = 1.0;
	ROUGHNESS = 0.2;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
