extends Node2D

signal play
signal start_credits

func _on_PlayButton_pressed():
	emit_signal("play")
	$menu_click.play()


func _on_CreditsButton_pressed():
	emit_signal("start_credits")
	$menu_click.play()
