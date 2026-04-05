extends Node2D

var light_receivers: Array[LightReceiver] = []
var are_all_receivers_active := false

func _ready() -> void:
	var members = get_tree().get_nodes_in_group("receiver")

	for member in members:
		if member is LightReceiver:
			light_receivers.append(member)

	for receiver in light_receivers:
		print(receiver.name)
	
func _process(_delta: float) -> void:
	if are_all_receivers_active:
		print("All receivers are active!")
		return
	for receiver in light_receivers:
		if !receiver.is_active:
			return
	are_all_receivers_active = true
