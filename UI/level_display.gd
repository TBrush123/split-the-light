# level_display.gd
extends Control

@export var level := 1
var glow_time := 0.0

func _draw():
    var center = size / 2
    
    # Подложка
    var rect = Rect2(0, 0, size.x, size.y)
    draw_rect(rect, Color(0.15, 0.2, 0.4, 0.4), true, -1.0)
    
    # Верхний блик
    draw_line(Vector2(4, 1), Vector2(size.x - 4, 1),
        Color(1, 1, 1, 0.15 + 0.05 * sin(glow_time * 2)), 1.0)
    
    # Текст "УРОВЕНЬ"
    draw_string(ThemeDB.fallback_font,
        Vector2(12, 16), "Level",
        HORIZONTAL_ALIGNMENT_LEFT, -1, 10,
        Color(0.5, 0.7, 1.0, 0.5))
    
    # Большой номер
    var glow_alpha = 0.8 + 0.2 * sin(glow_time * 1.5)
    draw_string(ThemeDB.fallback_font,
        Vector2(12, 38), str(level),
        HORIZONTAL_ALIGNMENT_LEFT, -1, 28,
        Color(0.7, 0.9, 1.0, glow_alpha))

func _process(delta):
    glow_time += delta
    queue_redraw()