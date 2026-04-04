extends RigidBody2D

@export var RedLight: LightRay
@export var GreenLight: LightRay  
@export var BlueLight: LightRay

@onready var rays: Array = [RedLight, GreenLight, BlueLight]

@export var output_angles = [-30, 0, 30]
@export var output_colors = [Color.RED, Color.GREEN, Color.BLUE]


var is_being_hit = false
var activated = false

func receive_hit():
	is_being_hit = true

func _ready():
	for ray in range(rays.size()):
		print(rays[ray].name)
		rays[ray].Particles.modulate = output_colors[ray]
		rays[ray].Particles.direction = Vector2.RIGHT.rotated(deg_to_rad(output_angles[ray]))
		rays[ray].Particles.emitting = false
		rays[ray].Particles.amount = 20
		rays[ray].Rayline.modulate = output_colors[ray]
		rays[ray].ray_width = 6
		rays[ray].deactivate()


func _physics_process(_delta):
	if is_being_hit:
		if not activated:
			set_rays_active(true)
	else:
		if activated:
			set_rays_active(false)
			
	# Reset for the next frame's check
	is_being_hit = false

func set_rays_active(state: bool):
	activated = state
	for ray in rays:
		ray.visible = state
		if state:
			ray.activate()
		else:
			ray.deactivate()
