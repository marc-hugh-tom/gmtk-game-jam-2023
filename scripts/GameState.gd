extends Node2D

onready var blocks_parent = get_node("blocks")
onready var paddle = get_node("Paddle")
onready var ball = get_node("balls/Ball")

const BlockFactory = preload("res://scenes/Block.tscn")

func _ready():
	pass
	#for position in _get_potential_block_placement_positions():
	#	_add_block(position)

func _add_block(position):
	var new_block = BlockFactory.instance()
	new_block.position = position
	blocks_parent.add_child(new_block)

func _process(delta):
	paddle.set_ball_position(ball.position)

func _get_potential_block_placement_positions():
	var block_width = 40 * 2
	var block_height = 10 * 2

	var left_pad = 20 + (block_width / 2)
	var right_pad = 20 + (block_width / 2)
	var top_pad = 20 + (block_height / 2)
	
	var bottom_pad = 200
	var spacing = 1
	var max_width = 1024
	var max_height = 600
	
	var width = max_width - left_pad - right_pad
	var height = max_height - top_pad - bottom_pad

	var placements = []
	
	for x in range(left_pad, width, block_width + spacing):
		for y in range(top_pad, height, block_height + spacing):
			placements.append(Vector2(x, y))
	
	return placements 
