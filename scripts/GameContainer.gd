extends Node2D

signal no_blocks

onready var block_grid = get_node("BlockGrid")
onready var paddle = get_node("Paddle")
onready var ball = get_node("balls/Ball")

var lost = false

func _ready():
	$PlacementUI.connect("block_placed", self, "_add_block")
	$PlacementUI.set_block_grid($BlockGrid)

func _add_block(input_global_position):
	var current_block = Globals.current_block
	block_grid.add_block_to_global_position(input_global_position, current_block[0])
	Globals.current_block_used()

func _process(delta):
	paddle.update_target_x_pos($balls.get_children())
	if $BlockGrid.get_block_count() == 0:
		if not lost:
			lost = true
			emit_signal("no_blocks")
