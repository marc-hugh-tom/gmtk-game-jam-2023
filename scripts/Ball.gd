extends RigidBody2D

var direction = Vector2.ZERO
var speed = 100.0

func _ready():
	bounce = 1.0
	friction = 0.0
	linear_velocity = Vector2(0.5, 0.5) * speed

func _integrate_forces(state):
	state.linear_velocity = state.linear_velocity.normalized() * speed
