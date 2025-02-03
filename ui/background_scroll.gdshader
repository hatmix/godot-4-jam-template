shader_type canvas_item;

uniform float speed: hint_range(0.1, 20.0) = 1.0;
uniform float angle_degrees : hint_range(0, 360) = 30;

void vertex() {
}

void fragment() {
	float angle_rad = radians(angle_degrees);
	vec2 direction = vec2(cos(angle_rad), sin(angle_rad));
	vec2 translate = UV - (TIME * speed / 10.0 * direction);
	COLOR = texture(TEXTURE, translate);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
