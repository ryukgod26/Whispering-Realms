shader_type canvas_item;

uniform sampler2D mask_texture;
uniform float fill_value : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec4 main_color = texture(TEXTURE, UV);
    float mask_val = texture(mask_texture, UV).r;
    
    // If the mask pixel is brighter than the fill value, hide it
    if (mask_val > fill_value) {
        main_color.a = 0.0;
    }
    
    COLOR = main_color * COLOR;
}