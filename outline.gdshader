shader_type canvas_item;

uniform int line_thickness : hint_range(0.0, 10.0);
uniform vec4 line_color : source_color = vec4(1.0);
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform vec2 screen_size;

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	
	// Get the size of the pixels on screen, and create a variable for out outline
	vec2 pixel_size = 1.0 / screen_size;//vec2(textureSize(screen_texture, 0));
	
	if (texture(screen_texture, SCREEN_UV).a == 0.0) {
		if (
			   (texture(screen_texture, SCREEN_UV + float(line_thickness) * pixel_size * vec2(-1, 0)).a != 0.0)
			|| (texture(screen_texture, SCREEN_UV + float(line_thickness) * pixel_size * vec2(1, 0)).a != 0.0)
			|| (texture(screen_texture, SCREEN_UV + float(line_thickness) * pixel_size * vec2(0, -1)).a != 0.0)
			|| (texture(screen_texture, SCREEN_UV + float(line_thickness) * pixel_size * vec2(0, 1)).a != 0.0)
		) {
			COLOR = line_color;
		}
	}
}