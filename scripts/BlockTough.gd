extends StaticBody2D

var health = 2

func on_collide_with_ball(ball, collision):
	health -= 1
	if health == 1:
		$Sprite.set_texture(load("res://assets/sprites/basic_block.png"))
	if health == 0:
		queue_free()

func block_grid_ref(block_grid):
	pass
