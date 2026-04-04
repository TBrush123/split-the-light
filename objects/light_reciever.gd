class_name LightReceiver
extends RigidBody2D

@export var lit_gem: Sprite2D
@export var unlit_gem: Sprite2D

@export var receiver_color: String = "white"

@onready var sprite_unlit = load("res://assets/" + receiver_color + "0.png")
@onready var sprite_lit = load("res://assets/" + receiver_color + "1.png")

var is_active := false
var is_being_hit := false
var hit_color := ""

func _ready():
	lit_gem.texture = sprite_lit
	unlit_gem.texture = sprite_unlit

func activate():
	var tween = create_tween()
	tween.tween_property(lit_gem, "modulate:a", 1.0, 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func deactivate():
	var tween = create_tween()
	tween.tween_property(lit_gem, "modulate:a", 0.0, 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func _physics_process(_delta):
	if is_being_hit and hit_color == receiver_color:
		if not is_active:
			set_rays_active(true)
	else:
		if is_active:
			set_rays_active(false)
             
	is_being_hit = false

func receive_hit(receive_color: String):
	is_being_hit = true
	hit_color = receive_color.to_lower()

func set_rays_active(state: bool):
	is_active = state
	if state:
		activate()
	else:
		deactivate()
