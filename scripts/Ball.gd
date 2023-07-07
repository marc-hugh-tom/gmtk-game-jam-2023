extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 100.0

func _ready():
	direction = Vector2(0.5, 0.5) 

func _physics_process(delta):
	var collision = move_and_collide(
		direction.normalized() * speed * delta
	)
	
	if is_instance_valid(collision):
		direction = direction.bounce(collision.get_normal())

		if collision.get_collider().is_in_group("block"):
			collision.get_collider().on_collide_with_ball()
