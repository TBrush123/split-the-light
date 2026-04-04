extends Button

@export var icon_color := Color(0.6, 0.8, 1.0)
@export var icon_type := "pause"  # "pause" | "restart" | "hint"

func _draw():
    var center = size / 2
    var r = min(size.x, size.y) * 0.5

    # Фон круга
    draw_circle(center, r, Color(icon_color.r, icon_color.g, icon_color.b, 0.12))
    
    # Обводка
    draw_arc(center, r, 0, TAU, 32, Color(icon_color.r, icon_color.g, icon_color.b, 0.35), 1.0)

    # Иконка
    match icon_type:
        "pause":
            draw_rect(Rect2(center.x - 7, center.y - 8, 4, 16), icon_color)
            draw_rect(Rect2(center.x + 3, center.y - 8, 4, 16), icon_color)
        "restart":
            draw_arc(center, r * 0.5, -PI * 0.8, PI * 0.8, 24, icon_color, 2.0)
            # стрелка
            var tip = center + Vector2(r * 0.45, r * 0.1)
            draw_line(tip, tip + Vector2(-6, -6), icon_color, 2.0)
            draw_line(tip, tip + Vector2(2, -8), icon_color, 2.0)
        "hint":
            draw_string(
                ThemeDB.fallback_font,
                center + Vector2(-5, 6),
                "?", HORIZONTAL_ALIGNMENT_LEFT, -1, 20, icon_color
            )

func _process(_delta):
    queue_redraw()