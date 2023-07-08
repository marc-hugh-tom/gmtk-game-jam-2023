extends Node2D

func set_counter_proportion(t):
	$Ring.get_material().set_shader_param("t", t)
