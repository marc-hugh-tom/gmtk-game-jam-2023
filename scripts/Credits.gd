extends Node2D

signal start_menu

func _on_BackButton_pressed():
	emit_signal("start_menu")
	$menu_click.play()
