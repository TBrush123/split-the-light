extends RigidBody2D

@export var RedLight: LightRay
@export var GreenLight: LightRay  
@export var BlueLight: LightRay

var dragging := false
var obj_offset:= Vector2.ZERO

@onready var rays: Array = [RedLight, GreenLight, BlueLight]

@export var output_angles = [-30, 0, 30]


var is_being_hit = false
var activated = false

func receive_hit():
	is_being_hit = true

func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - obj_offset

func _ready():
	for ray in range(rays.size()):
		rays[ray].deactivate() 
		print(rays[ray].name)
		rays[ray].Particles.direction = Vector2.RIGHT.rotated(deg_to_rad(output_angles[ray]))
		rays[ray].Particles.emitting = false
		rays[ray].Particles.amount = 20
		rays[ray].ray_width = 6

func _physics_process(_delta):
	if is_being_hit:
		if not activated:
			set_rays_active(true)
	else:
		if activated:
			set_rays_active(false)
			
	is_being_hit = false

func set_rays_active(state: bool):
	activated = state
	for ray in rays:
		ray.visible = state
		if state:
			ray.activate()
		else:
			ray.deactivate()

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
