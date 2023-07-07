extends Node2D

signal block_placed

const BLOCK = preload("res://scenes/Block.tscn")
const BORDER_MARGIN = 60
const HALF_SPACING = 3
const COLUMNS = 8
const ROWS = 10

var block_size

var guide_block

func _ready():
	guide_block = BLOCK.instance()
	guide_block.set_collision_layer_bit(0, 0)
	guide_block.set_collision_mask_bit(0, 0)
	block_size = (
		guide_block.get_node("CollisionShape2D").get_shape().get_extents() +
		Vector2.ONE * HALF_SPACING
	) * 2
	add_child(guide_block)

func _physics_process(delta):
	var mouse = get_local_mouse_position()
	guide_block.set_position(Vector2(
		clamp(round(mouse.x / block_size.x), -COLUMNS/2, COLUMNS/2) * block_size.x,
		clamp(round(mouse.y / block_size.y), -ROWS/2, ROWS/2) * block_size.y
	))

func _input(event):
	if event.is_action_pressed("left_click"):
		emit_signal("block_placed", guide_block.get_position())

