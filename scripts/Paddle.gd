extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 400.0

var ball_position = null

var DEBUG = false

func set_ball_position(pos):
	ball_position = pos

func _physics_process(delta):
	if ball_position != null:
		position.x = lerp(position.x, ball_position.x, 0.7)
	
	if DEBUG:
		direction = Vector2.ZERO
		if Input.is_action_pressed("ui_left"):
			direction += Vector2(-1, 0)
		if Input.is_action_pressed("ui_right"):
			direction += Vector2(1, 0)
	
		position += direction.normalized() * speed * delta
