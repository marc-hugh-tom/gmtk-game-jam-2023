extends Node2D

onready var blocks_parent = get_node("blocks")
onready var paddle = get_node("Paddle")
onready var ball = get_node("balls/Ball")

const BlockFactory = preload("res://scenes/Block.tscn")

func _ready():
	$PlacementUI.connect("block_placed", self, "_add_block")

func _add_block(position):
	var new_block = BlockFactory.instance()
	new_block.position = position + $PlacementUI.position
	blocks_parent.add_child(new_block)

func _process(delta):
	paddle.set_ball_position(ball.position)
