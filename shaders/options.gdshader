shader_type canvas_item;

uniform float glass_intensity : hint_range(0.0, 5.0);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec4 color = textureLod(SCREEN_TEXTURE, SCREEN_UV, glass_intensity);
    COLOR = color;
}