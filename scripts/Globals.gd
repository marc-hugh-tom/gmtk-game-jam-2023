extends Node2D

var BLOCK_TYPES = [
	[
		preload("res://scenes/BlockBasic.tscn"),
		"Rubbish block",
		1.0
	],
	[
		preload("res://scenes/BlockTough.tscn"),
		"Better block",
		0.5
	]
]

var block_cum_probs = [0.0]
var current_block
var next_block

func _ready():
	_populate_block_probabilities()
	current_block = get_next_block()
	next_block = get_next_block()

func _populate_block_probabilities():
	var summed_weights = 0.0
	for block_info in BLOCK_TYPES:
		summed_weights += block_info[2]
	for block_info in BLOCK_TYPES:
		block_cum_probs.append(
			block_cum_probs.back() + block_info[2] / summed_weights
		)
	# Remove zero
	block_cum_probs.pop_front()

func get_next_block():
	var random_num = randf()
	var idx = 0
	for prob in block_cum_probs:
		if random_num <= prob:
			return(BLOCK_TYPES[idx])
		idx += 1

func current_block_used():
	current_block = next_block
	next_block = get_next_block()

func get_placement_timer_proportion():
	return(($PlacementTimer.wait_time - $PlacementTimer.time_left) / $PlacementTimer.wait_time)

func start_placement_timer():
	$PlacementTimer.start()

func get_placement_timer():
	return($PlacementTimer)
