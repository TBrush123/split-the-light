shader_type canvas_item;

uniform vec4 tint : source_color = vec4(0.1, 0.15, 0.3, 0.7);
uniform float edge_glow : hint_range(0.0, 1.0) = 0.25;

void fragment() {
    vec4 c = tint;
    float top = smoothstep(0.05, 0.0, UV.y) * edge_glow;
    float bottom = smoothstep(0.95, 1.0, UV.y) * (edge_glow * 0.4);
    c.rgb += vec3(top + bottom);
    COLOR = c;
}