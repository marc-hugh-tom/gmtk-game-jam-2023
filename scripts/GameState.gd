extends Node2D

onready var timer_label = $TimerLabel
onready var win_countdown_timer = $WinCountdownTimer

func _process(delta):
	var minutes = floor(win_countdown_timer.time_left / 60)
	var seconds = int(win_countdown_timer.time_left) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]
