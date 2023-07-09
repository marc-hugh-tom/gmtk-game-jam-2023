extends StaticBody2D

#signal block_collide

#func _init(type):
#	pass

func on_collide_with_ball(ball, collision):
	# emit_signal("block_collide" [self.type])
	queue_free()

func block_grid_ref(block_grid):
	$RepulseArea.monitoring = true
	$CPUParticles2D.emitting = true

func _physics_process(delta):
	if $RepulseArea.monitoring:
		var bodies = $RepulseArea.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("balls"):
				var mod = (
					Vector2(0, 1) *
					abs(80 - body.global_position.distance_to(global_position)) *
					delta
				)
				body.direction = (body.direction.normalized() + mod).normalized()
