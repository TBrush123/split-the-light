extends Node2D

var light_receivers: Array[LightReceiver] = []
var are_all_receivers_active := false
var current_level := 0

@onready var hud: CanvasLayer = $HUD

var time := 0.0

func _ready() -> void:
	hud.set_level(current_level)
	hud.restart_pressed.connect(_on_restart)
	hud.pause_pressed.connect(_on_pause)
	hud.hint_pressed.connect(_on_hint)
	hud.next_pressed.connect(_on_next)
	var members = get_tree().get_nodes_in_group("receiver")

	for member in members:
		if member is LightReceiver:
			light_receivers.append(member)

	for receiver in light_receivers:
		print(receiver.name)
	
func _process(_delta: float) -> void:
	if are_all_receivers_active:
		time += _delta
		if time >= 3.0:
			print("All receivers are active!")
			time = 0.0
	
	for receiver in light_receivers:
		if !receiver.is_active:
			return
	are_all_receivers_active = true

func _on_restart():
	get_tree().reload_current_scene()

func _on_pause():
	get_tree().paused = not get_tree().paused

func _on_hint():
	pass

func _on_next():
	# загрузи следующий уровень
	pass
			
		
