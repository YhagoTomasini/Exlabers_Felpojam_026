shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0);
uniform float wave_strength = 1.0;
uniform float wave_speed = 1.0;
uniform float wave_frequency = 1.0;

void fragment() {
    vec2 uv = UV;

    float wave = sin((uv.x * wave_frequency) + TIME * wave_speed) * (wave_strength / 100.0);

    float liquid_level = progress + wave;

    if (uv.y < liquid_level) {
        discard;
    }

    COLOR = texture(TEXTURE, uv);
}