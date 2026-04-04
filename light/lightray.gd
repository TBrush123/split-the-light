class_name LightRay
extends Node2D

@export var Particles: CPUParticles2D
@export var Rayline: Line2D
@export var active := false

@export_group("Ray Settings")
@export var max_bounces := 5
@export var ray_width := 12
@export var ray_color := Color(1, 1, 1)

signal hit_prism(prism)
signal prism_cleared

var current_points = []
var target_points = []
var time := 0.0
var hit_receivers = []
var hit_prisms = []

func cast_laser(origin: Vector2, direction: Vector2, max_bounces := 5):
	var space = get_world_2d().direct_space_state
	
	var points = [origin]
	var current_origin = origin
	var current_dir = direction.normalized() 
	
	for i in range(max_bounces):
		var query = PhysicsRayQueryParameters2D.create(
			current_origin,
			current_origin + current_dir * 1000
		)
		query.exclude = [get_parent()]

		var result = space.intersect_ray(query)
		
		if result and result.collider.is_in_group("reflective"):
			var hit_pos = result.position
			var normal = result.normal
			
			points.append(hit_pos)
			
			# отражение
			current_dir = current_dir.bounce(normal)
			current_origin = hit_pos + current_dir * 0.1 # небольшое смещение, чтобы избежать застревания
		elif result and result.collider.is_in_group("absorptive"):
			points.append(result.position)
			Particles.global_position = result.position
			Particles.emitting = true
			Particles.direction = -current_dir
			break
		elif result and result.collider.is_in_group("receiver"):
			print("Receiver hit")
			points.append(result.position)
			if not hit_receivers.has(result.collider):
				hit_receivers.append(result.collider)
				emit_signal("hit_prism", result.collider)
				result.collider.activate()
			Particles.global_position = result.position
			Particles.emitting = true
			Particles.direction = -current_dir
			break
		elif result and result.collider.is_in_group("prism"):
			var prism = result.collider
			var hit_normal = result.normal # The direction the surface is "facing"
			points.append(result.position)

			var prism_bottom_direction = prism.global_transform.y 

			var side_dot = hit_normal.dot(prism_bottom_direction)

			if side_dot > 0.9: 
				if prism.has_method("receive_hit"):
					prism.receive_hit()
			else:
				Particles.global_position = result.position
				Particles.emitting = true
				Particles.direction = -current_dir
				print("Hit a side other than the bottom")
			
			points.append(result.position)
		else:
			Particles.emitting = false
			points.append(current_origin + current_dir * 1000)
			break
	
	return points

func _draw():
	var origin = Vector2(100, 100)
	var direction = Vector2(1, 0)
	var points = cast_laser(origin, direction)
	Rayline.points = cast_laser(global_position, Vector2.RIGHT)

func update_receivers():
	get_tree().call_group("receiver", "deactivate")
	for r in hit_receivers:
		r.activate()
func update_prisms():
	get_tree().call_group("prism", "deactivate_prism")

func activate():
	active = true
	print("Light ON")

func deactivate():
	active = false
	print("Light OFF")

func _process(delta: float) -> void:
	time += delta
	hit_receivers.clear()
	if not active:
		Rayline.points = []
		return
	
	if hit_prisms.is_empty():
		prism_cleared.emit()
	else:
		for p in hit_prisms:
			hit_prism.emit(p)

	target_points = cast_laser(global_position, global_transform.x)
	
	if current_points.size() != target_points.size():
		current_points = target_points.map(func(p): return to_local(p))
	else:
		for i in range(current_points.size()):
			var local_target = to_local(target_points[i])
			current_points[i] = current_points[i].lerp(local_target, 0.2)

	Rayline.points = current_points
	Rayline.width = ray_width + 2 * sin(time * 5)

	update_prisms()
	update_receivers()

func _ready():
	add_to_group("light_ray")
