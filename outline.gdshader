shader_type canvas_item;

uniform int line_thickness : hint_range(0.0, 10.0);
uniform vec4 line_color : source_color = vec4(1.0);
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
    COLOR = texture(screen_texture, SCREEN_UV);

    vec2 pixel_size = SCREEN_PIXEL_SIZE;
    

    if (texture(screen_texture, SCREEN_UV).a == 0.0) {
		for (int i = 0; i < line_thickness; i++) {
			float offset = float(i) + 0.0;
	        if (
	            (texture(screen_texture, SCREEN_UV + offset * pixel_size * vec2(-1, 0)).a != 0.0) ||
	            (texture(screen_texture, SCREEN_UV + offset * pixel_size * vec2(1, 0)).a != 0.0) ||
	            (texture(screen_texture, SCREEN_UV + offset * pixel_size * vec2(0, -1)).a != 0.0) ||
	            (texture(screen_texture, SCREEN_UV + offset * pixel_size * vec2(0, 1)).a != 0.0) ||
	            (texture(screen_texture, SCREEN_UV + offset * pixel_size * vec2(-1, -1)).a != 0.0) ||
	            (texture(screen_texture, SCREEN_UV + offset * pixel_size * vec2(-1, 1)).a != 0.0) ||
	            (texture(screen_texture, SCREEN_UV + offset * pixel_size * vec2(1, -1)).a != 0.0) ||
	            (texture(screen_texture, SCREEN_UV + offset * pixel_size * vec2(1, 1)).a != 0.0)
	        ) {
	            COLOR = line_color;
	        }
		}
    }
}
