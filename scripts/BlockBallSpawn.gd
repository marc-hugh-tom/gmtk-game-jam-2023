extends StaticBody2D

signal spawn_ball

func on_collide_with_ball(ball, collision):
	emit_signal("spawn_ball", position)
	queue_free()

func block_grid_ref(block_grid):
	pass
