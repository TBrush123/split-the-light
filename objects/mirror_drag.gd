extends RigidBody2D

var dragging := false
var obj_offset:= Vector2.ZERO


func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - obj_offset

func _input(event):
	if not dragging:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			self.rotate(deg_to_rad(1))  # Rotate clockwise by 0.1 radians
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			self.rotate(deg_to_rad(-1))  # Rotate counterclockwise by 0.1 radians

func _on_button_button_down() -> void:
	dragging = true
	obj_offset = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
