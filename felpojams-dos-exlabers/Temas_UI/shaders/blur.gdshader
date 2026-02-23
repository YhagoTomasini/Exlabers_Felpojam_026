shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 10.0) = 8.0;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
    vec2 screen_uv = SCREEN_UV;
    vec2 pixel_size = 1.0 / vec2(textureSize(screen_texture, 0));
    
    vec4 color = vec4(0.0);
    
    // Blur simples 9 amostras
    color += texture(screen_texture, screen_uv + pixel_size * vec2(-blur_amount, -blur_amount));
    color += texture(screen_texture, screen_uv + pixel_size * vec2( 0.0, -blur_amount));
    color += texture(screen_texture, screen_uv + pixel_size * vec2( blur_amount, -blur_amount));
    
    color += texture(screen_texture, screen_uv + pixel_size * vec2(-blur_amount,  0.0));
    color += texture(screen_texture, screen_uv);
    color += texture(screen_texture, screen_uv + pixel_size * vec2( blur_amount,  0.0));
    
    color += texture(screen_texture, screen_uv + pixel_size * vec2(-blur_amount, blur_amount));
    color += texture(screen_texture, screen_uv + pixel_size * vec2( 0.0, blur_amount));
    color += texture(screen_texture, screen_uv + pixel_size * vec2( blur_amount, blur_amount));
    
    COLOR = color / 9.0;
}