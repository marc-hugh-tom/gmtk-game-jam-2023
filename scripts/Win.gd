extends Node2D

signal start_menu

func _on_MainMenuButton_pressed():
	emit_signal("start_menu")
