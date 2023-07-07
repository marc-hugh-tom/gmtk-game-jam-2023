extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 400.0

func _physics_process(delta):
	direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(1, 0)

	position += direction.normalized() * speed * delta
