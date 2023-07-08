extends Node2D

signal block_placed

const BLOCK = preload("res://scenes/Block.tscn")
const INDICATORS = preload("res://scenes/BlockPositionIndicator.tscn")

var guide_block
var block_grid

func set_block_grid(input_block_grid):
	block_grid = input_block_grid
	guide_block = BLOCK.instance()
	guide_block.set_collision_layer_bit(0, 0)
	guide_block.set_collision_mask_bit(0, 0)
	guide_block.set_modulate(Color(1.0, 1.0, 1.0, 0.5))
	add_child(guide_block)
	for pos in block_grid.get_all_block_global_positions():
		var indicator = INDICATORS.instance()
		$Indicators.add_child(indicator)
		indicator.set_global_position(pos)

func _physics_process(delta):
	var mouse = get_global_mouse_position()
	guide_block.set_global_position(block_grid.snap_to_grid(mouse))

func _input(event):
	if event.is_action_pressed("left_click"):
		emit_signal("block_placed", guide_block.get_global_position())
