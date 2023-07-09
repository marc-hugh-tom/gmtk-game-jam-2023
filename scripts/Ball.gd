extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 400.0

const LOOKAHEAD_DISTANCE = 1000.0
const NUMBER_OF_RAYCASTS = 2


func _ready():
	for _i in range(NUMBER_OF_RAYCASTS):
		var new_ray = RayCast2D.new()
		new_ray.enabled = true
		new_ray.collide_with_areas = true
		$RayCasts.add_child(new_ray)

func _physics_process(delta):
	var collision = move_and_collide(
		direction.normalized() * speed * delta
	)
	if is_instance_valid(collision):
		set_direction(direction.bounce(collision.get_normal()))
		if collision.get_collider().is_in_group("ball_collidable"):
			collision.get_collider().on_collide_with_ball(self, collision)
	update_raycasts()

func tweak_direction(new_direction):
	set_direction((direction + new_direction).normalized())

func set_direction(new_direction):
	direction = new_direction

func update_raycasts():
	var ray_position = Vector2.ZERO
	var ray_direction = direction.normalized()
	var ignore = null
	for raycast in $RayCasts.get_children():
		raycast.clear_exceptions()
		if not ray_position == null:
			raycast.set_position(ray_position)
			raycast.set_cast_to(ray_direction * LOOKAHEAD_DISTANCE)
			if not ignore == null:
				raycast.add_exception(ignore)
		raycast.force_raycast_update()
		if raycast.is_colliding():
			ray_position = to_local(raycast.get_collision_point())
			var normal = raycast.get_collision_normal()
			if normal.length() > 0.0:
				ray_direction = ray_direction.bounce(normal.normalized()).normalized()
			ignore = raycast.get_collider()
		else:
			ray_position = null

func get_raycast_catcher_destination():
	for raycast in $RayCasts.get_children():
		if is_instance_valid(raycast) and raycast.is_colliding():
			var collider = raycast.get_collider()
			if is_instance_valid(collider) and collider.is_in_group("raycast_catcher"):
				return(raycast.get_collision_point())
	return(null)

func _draw():
	var center = Vector2(0, 0)
	var radius = 10
	var angle_from = 0
	var angle_to = 360
	var color = Color("#ffda45")
	
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
