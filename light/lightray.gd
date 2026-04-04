extends Node2D

@export var Particles: CPUParticles2D
var current_points = []
var target_points = []
var time := 0.0

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
		else:
			Particles.emitting = false
			points.append(current_origin + current_dir * 1000)
			break
	
	return points

func _draw():
	var origin = Vector2(100, 100)
	var direction = Vector2(1, 0)
	var points = cast_laser(origin, direction)
	$Line2D.points = cast_laser(global_position, Vector2.RIGHT)

func _process(delta: float) -> void:
	time += delta

	target_points = cast_laser(global_position, Vector2.RIGHT)
	
	if current_points.size() != target_points.size():
		current_points = target_points.duplicate()
	else:
		for i in range(current_points.size()):
			current_points[i] = to_local(target_points[i])
			current_points[i] = current_points[i].lerp(target_points[i], 0.2)
	
	$Line2D.points = current_points
	$Line2D.width = 12 + 2 * sin(time * 5)
