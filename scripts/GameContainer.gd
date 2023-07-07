extends Node2D

onready var blocks = get_node("blocks")
onready var paddle = get_node("Paddle")
onready var ball = get_node("balls/Ball")

const BlockFactory = preload("res://scenes/Block.tscn")

func _ready():
	$PlacementUI.connect("block_placed", self, "_add_block")

func _add_block(position):
	position += $PlacementUI.position
	if get_block_at(position) == null:
		var new_block = BlockFactory.instance()
		new_block.position = position
		blocks.add_child(new_block)

func _process(delta):
	paddle.set_ball_position(ball.position)

func get_block_at(position):
	for block in blocks.get_children():
		if block.position.distance_squared_to(position) < 1:
			return block
	return null
