extends StaticBody2D

var sprites = [
	load("res://assets/sprites/spawn_block_0.png"),
	load("res://assets/sprites/spawn_block_1.png"),
	load("res://assets/sprites/spawn_block_2.png"),
	load("res://assets/sprites/spawn_block_3.png"),
	load("res://assets/sprites/spawn_block_4.png"),
	load("res://assets/sprites/spawn_block_5.png")
]
var current_sprite = 0
var block_grid

func _ready():
	$Timer.connect("timeout", self, "spawn_neighbour")

func _process(delta):
	var sprite_idx = int(round((1.0 - ($Timer.time_left / $Timer.wait_time)) * (len(sprites) - 1)))
	if not current_sprite == sprite_idx:
		current_sprite = sprite_idx
		$Sprite.set_texture(sprites[current_sprite])

func on_collide_with_ball(ball, collision):
	queue_free()

func spawn_neighbour():
	if is_instance_valid(block_grid):
		var grid_position = block_grid.global_position_to_grid_position(global_position)
		grid_position += Vector2(1, 0)
		if block_grid.test_valid_grid_pos(grid_position) and block_grid.test_grid_pos_empty(grid_position):
			block_grid.add_block(grid_position, load("res://scenes/BlockSpawn.tscn"))

func block_grid_ref(input_block_grid):
	block_grid = input_block_grid
