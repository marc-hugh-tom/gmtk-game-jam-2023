extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 3.0

var ball_position = null

var DEBUG = false

var left_clamp = 142.0
var right_clamp = 882.0

func set_ball_position(pos):
	ball_position = pos

func _physics_process(delta):
	if ball_position != null and !DEBUG:
		var y = position.y
		var new_position = position.linear_interpolate(ball_position, 4.0 * delta)
		position.y = y 
	
		var diff = clamp(new_position.x - position.x, -speed, speed)
		position.x += diff
		direction = Vector2(diff, 0)

	if DEBUG:
		direction = Vector2.ZERO
		if Input.is_action_pressed("ui_left"):
			direction += Vector2(-1, 0)
		if Input.is_action_pressed("ui_right"):
			direction += Vector2(1, 0)
	
		position += direction.normalized() * speed * delta

	position.x = clamp(position.x, left_clamp, right_clamp)

func on_collide_with_ball(ball, collision):
	ball.tweak_direction((collision.get_normal() * 2) + direction)
