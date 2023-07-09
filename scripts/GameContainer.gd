extends Node2D

signal no_blocks
signal life_lost

onready var block_grid = get_node("BlockGrid")
onready var paddle = get_node("Paddle")
var ball_factory = preload("res://scenes/Ball.tscn")

var lost = false

func _ready():
	$PlacementUI.connect("block_placed", self, "_add_block")
	$PlacementUI.set_block_grid($BlockGrid)
	$BallCatcher.connect("body_entered", self, "body_entered_ball_catcher")
	add_new_ball()

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

func body_entered_ball_catcher(body):
	if body.is_in_group("balls"):
		var num_balls = $balls.get_child_count()
		body.queue_free()
		if num_balls <= 1:
			add_new_ball()
			emit_signal("life_lost")

func add_new_ball():
	var new_ball = ball_factory.instance()
	new_ball.position = $Paddle.position - Vector2(0, 30)
	new_ball.direction = Vector2(randf() - 0.5, -1)
	$balls.call_deferred("add_child", new_ball)
