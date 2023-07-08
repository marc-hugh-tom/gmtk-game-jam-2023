extends Node2D

signal block_placed

const BLOCK = preload("res://scenes/BlockBasic.tscn")
const INDICATORS = preload("res://scenes/BlockPositionIndicator.tscn")

var guide_block
var block_grid
var able_to_place = false

func set_block_grid(input_block_grid):
	block_grid = input_block_grid
	update_guide_block()
	for pos in block_grid.get_all_block_global_positions():
		var indicator = INDICATORS.instance()
		$Indicators.add_child(indicator)
		indicator.set_global_position(pos)
	Globals.get_placement_timer().connect("timeout", self, "countdown_finish")
	start_countdown()

func _process(delta):
	var mouse = get_global_mouse_position()
	$Cursor.set_global_position(mouse)
	if is_instance_valid(guide_block):
		guide_block.set_global_position(block_grid.snap_to_grid(mouse))
	$Cursor.set_counter_proportion(Globals.get_placement_timer_proportion())

func _input(event):
	if event.is_action_pressed("left_click"):
		if able_to_place:
			emit_signal("block_placed", guide_block.get_global_position())
			update_guide_block()
			start_countdown()

func update_guide_block():
	if is_instance_valid(guide_block):
		remove_child(guide_block)
		guide_block.free()
		guide_block = null
	guide_block = Globals.current_block[0].instance()
	guide_block.set_collision_layer_bit(0, 0)
	guide_block.set_collision_mask_bit(0, 0)
	guide_block.set_modulate(Color(1.0, 1.0, 1.0, 0.5))
	add_child(guide_block)
	move_child(guide_block, 1)

func start_countdown():
	Globals.start_placement_timer()
	able_to_place = false
	guide_block.hide()
	$Cursor.show()

func countdown_finish():
	able_to_place = true
	guide_block.show()
	$Cursor.hide()
