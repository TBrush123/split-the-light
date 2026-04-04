shader_type canvas_item;

uniform float opacity : hint_range(0.0, 1.0) = 0.15;
uniform vec4 tint : source_color = vec4(0.3, 0.4, 0.8, 1.0);
uniform float edge_brightness : hint_range(0.0, 1.0) = 0.3;

void fragment() {
    vec2 uv = UV;
    
    // Основной цвет стекла
    vec4 glass = vec4(tint.rgb, opacity);
    
    // Светлая полоска сверху — имитация блика
    float top_edge = smoothstep(0.04, 0.0, uv.y) * edge_brightness;
    glass.rgb += vec3(top_edge);
    
    // Светлая полоска снизу — тонкая граница
    float bottom_edge = smoothstep(0.97, 1.0, uv.y) * 0.15;
    glass.rgb += vec3(bottom_edge);
    
    COLOR = glass;
}