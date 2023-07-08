extends Node2D

onready var block_grid = get_node("BlockGrid")
onready var paddle = get_node("Paddle")
onready var ball = get_node("balls/Ball")

func _ready():
	$PlacementUI.connect("block_placed", self, "_add_block")
	$PlacementUI.set_block_grid($BlockGrid)

func _add_block(input_global_position):
	block_grid.add_block_to_global_position(input_global_position)

func _process(delta):
	paddle.set_ball_position(ball.position)
