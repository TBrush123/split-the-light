extends RigidBody2D

var is_active := false

func activate():
	if not is_active:
		is_active = true
		print("Receiver ON")
		modulate = Color(1, 1, 0) # подсветка

func deactivate():
	if is_active:
		is_active = false
		print("Receiver OFF")
		modulate = Color(0.5, 0.5, 0.5)
