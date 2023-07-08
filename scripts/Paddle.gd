extends KinematicBody2D

var direction = Vector2.ZERO
var max_speed = 300.0

var ball_position = null

var DEBUG = false

var left_clamp = 142.0
var right_clamp = 882.0

var target_x_pos = (right_clamp + left_clamp) / 2

func update_target_x_pos(balls):
	var ball_positions = []
	var ball_distances = []
	var raycast_catcher_dests = []
	var ray_distances = []
	for ball in balls:
		ball_positions.append(ball.position.x)
		ball_distances.append(abs(ball.position.x - position.x))
		var dest = ball.get_raycast_catcher_destination()
		if not dest == null:
			var local_dest = get_parent().to_local(dest)
			raycast_catcher_dests.append(local_dest.x)
			ray_distances.append(abs(local_dest.x - position.x))
	if len(raycast_catcher_dests) > 0:
		target_x_pos = raycast_catcher_dests[ray_distances.find(ray_distances.min())]
	else:
		target_x_pos = ball_positions[ball_distances.find(ball_distances.min())]

func _physics_process(delta):
	var target_position = Vector2(target_x_pos, position.y)
	if !DEBUG:
		var diff = clamp(((target_x_pos - position.x) / 50) * max_speed, - max_speed, max_speed)
		position.x += diff * delta
		direction = Vector2(diff, 0)
	if DEBUG:
		direction = Vector2.ZERO
		if Input.is_action_pressed("ui_left"):
			direction += Vector2(-1, 0)
		if Input.is_action_pressed("ui_right"):
			direction += Vector2(1, 0)
		position += direction.normalized() * max_speed * delta
	position.x = clamp(position.x, left_clamp, right_clamp)

func on_collide_with_ball(ball, collision):
	pass
#	ball.tweak_direction(direction)


