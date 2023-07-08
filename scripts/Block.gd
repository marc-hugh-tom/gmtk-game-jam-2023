extends StaticBody2D

#signal block_collide

#func _init(type):
#	pass

func on_collide_with_ball(ball, collision):
	# emit_signal("block_collide" [self.type])
	queue_free()
