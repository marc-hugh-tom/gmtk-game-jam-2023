extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 200.0

func _ready():
	direction = Vector2(-0.5, 0.5) 

func _physics_process(delta):
	var collision = move_and_collide(
		direction.normalized() * speed * delta
	)
	
	if is_instance_valid(collision):
		direction = direction.bounce(collision.get_normal())

		if collision.get_collider().is_in_group("block"):
			collision.get_collider().on_collide_with_ball()
	update()

func _draw():
	var center = Vector2(0, 0)
	var radius = 10
	var angle_from = 0
	var angle_to = 360
	var color = Color( 1, 0.854902, 0.72549, 1 )
	
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
