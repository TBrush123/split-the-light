extends Control


# theme_setup.gd - запусти один раз чтобы создать тему
func create_theme() -> Theme:
	var theme = Theme.new()
	
	# Панели
	var panel_style = StyleBoxFlat.new()
	panel_style.bg_color = Color(0.07, 0.07, 0.13, 0.85)
	panel_style.border_color = Color(1, 1, 1, 0.1)
	panel_style.set_border_width_all(1)
	theme.set_stylebox("panel", "PanelContainer", panel_style)
	
	# Кнопки
	var btn_normal = StyleBoxFlat.new()
	btn_normal.bg_color = Color(1, 1, 1, 0.06)
	btn_normal.border_color = Color(1, 1, 1, 0.13)
	btn_normal.set_border_width_all(1)
	btn_normal.corner_radius_top_left = 8
	btn_normal.corner_radius_top_right = 8
	btn_normal.corner_radius_bottom_left = 8
	btn_normal.corner_radius_bottom_right = 8
	
	var btn_hover = StyleBoxFlat.new()
	btn_hover.bg_color = Color(1, 1, 1, 0.12)
	btn_hover.border_color = Color(1, 1, 1, 0.2)
	btn_hover.set_border_width_all(1)
	btn_hover.corner_radius_top_left = 8
	btn_hover.corner_radius_top_right = 8
	btn_hover.corner_radius_bottom_left = 8
	btn_hover.corner_radius_bottom_right = 8
	
	theme.set_stylebox("normal", "Button", btn_normal)
	theme.set_stylebox("hover", "Button", btn_hover)
	theme.set_color("font_color", "Button", Color(1, 1, 1, 0.7))
	theme.set_color("font_color", "Label", Color(1, 1, 1, 0.9))
	
	return theme
