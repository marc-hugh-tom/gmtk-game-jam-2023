extends Node2D

onready var blocks_parent = get_node("blocks")

const BlockFactory = preload("res://scenes/Block.tscn")

func _ready():
	_add_block(Vector2(200, 200))

func _add_block(position):
	var new_block = BlockFactory.instance()
	new_block.position = position
	
	blocks_parent.add_child(new_block)

func _get_potential_block_placement_positions():
	# return array of positions
	pass
