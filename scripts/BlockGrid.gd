extends Node2D

const BLOCK = preload("res://scenes/BlockBasic.tscn")
const HALF_SPACING = 3
# Columns and rows have to be odd
const COLUMNS = 9
const ROWS = 11

const MISSING = 2

var block_matrix = []
var block_size

func _ready():
	# Establish size of a block with spacing
	var guide_block = BLOCK.instance()
	block_size = (
		guide_block.get_node("CollisionShape2D").get_shape().get_extents() +
		Vector2.ONE * HALF_SPACING
	) * 2
	# Initialise block matrix
	for col_idx in range(COLUMNS):
		var row = []
		for row_idx in range(ROWS):
			row.append(null)
		block_matrix.append(row)
	# Initialise starting blocks
	_init_starting_blocks()

func test_valid_grid_pos(grid_position):
	return(
		0 <= int(grid_position.x) and int(grid_position.x) < COLUMNS and
		0 <= int(grid_position.y) and int(grid_position.y) < ROWS
	)

func test_grid_pos_empty(grid_position):
	if not test_valid_grid_pos(grid_position):
		return(false)
	return(not is_instance_valid(get_block(grid_position)))

func get_block(grid_position):
	return(block_matrix[int(grid_position.x)][int(grid_position.y)])

func delete_block(grid_position):
	var block = get_block(grid_position)
	if is_instance_valid(block):
		block_matrix[int(grid_position.x)][int(grid_position.y)] = null
		block.queue_free()

func add_block(grid_position, block_factory):
	delete_block(grid_position)
	var block = block_factory.instance()
	block_matrix[int(grid_position.x)][int(grid_position.y)] = block
	add_child(block)
	block.set_global_position(grid_position_to_global_position(grid_position))
	block.block_grid_ref(self)

func add_block_to_global_position(input_global_position, block_factory):
	add_block(global_position_to_grid_position(input_global_position), block_factory)

func snap_to_grid(input_global_position):
	return(grid_position_to_global_position(global_position_to_grid_position(input_global_position)))

func global_position_to_grid_position(input_global_position):
	var local_position = to_local(input_global_position)
	return(
		Vector2(
			clamp(round(local_position.x / block_size.x), -COLUMNS/2, COLUMNS/2),
			clamp(round(local_position.y / block_size.y), -ROWS/2, ROWS/2)
		) + Vector2(COLUMNS/2, ROWS/2)
	)

func grid_position_to_global_position(input_grid_position):
	return(to_global((input_grid_position - Vector2(COLUMNS/2, ROWS/2)) * block_size))

func get_all_block_global_positions():
	var return_positions = []
	for col_idx in range(COLUMNS):
		for row_idx in range(ROWS):
			return_positions.append(grid_position_to_global_position(Vector2(col_idx, row_idx)))
	return(return_positions)

func _init_starting_blocks():
	for col_idx in range(COLUMNS):
		for row_idx in range(ROWS):
			if (
				col_idx >= MISSING and
				col_idx < COLUMNS - MISSING and
				row_idx >= MISSING and
				row_idx < ROWS - MISSING
			):
				add_block(Vector2(col_idx, row_idx), BLOCK)

func get_block_count():
	var count = 0
	for child in get_children():
		if is_instance_valid(child) and child.is_in_group("ball_collidable"):
			count += 1
	return(count)
