shader_type canvas_item;

uniform sampler2D normal_map : hint_normal;
uniform float scroll_y = 0.0;

void fragment() {
	vec2 uv = UV;
	uv.y += scroll_y;

	COLOR = texture(TEXTURE, uv);
	NORMAL = texture(normal_map, uv).rgb;
}