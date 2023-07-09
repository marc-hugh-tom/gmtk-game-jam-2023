extends Node2D

onready var timer_label = $TimerLabel
onready var win_countdown_timer = $WinCountdownTimer

signal win
signal lose

var lives = 3

func _ready():
	$GameContainer.connect("no_blocks", self, "_no_blocks_callback")
	$GameContainer.connect("life_lost", self, "deduct_life")
	Globals.connect("current_block_changed", self, "current_block_changed")
	current_block_changed()

func _process(delta):
	var minutes = floor(win_countdown_timer.time_left / 60)
	var seconds = int(win_countdown_timer.time_left) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func _on_WinCountdownTimer_timeout():
	emit_signal("win")

func _no_blocks_callback():
	emit_signal("lose")

func current_block_changed():
	for child in $CurrentContainer/Container/Current.get_children():
		child.queue_free()
	$CurrentContainer/Container/Current.add_child(Globals.current_block[0].instance())
	$CurrentContainer/CurrentDescription.text = Globals.current_block[1]
	for child in $NextContainer/Container/Next.get_children():
		child.queue_free()
	$NextContainer/Container/Next.add_child(Globals.next_block[0].instance())
	$NextContainer/NextDescription.text = Globals.next_block[1]

func deduct_life():
	lives -= 1
	for child in $LivesContainer/Container.get_children():
		if int(child.name) >= lives:
			child.hide()
	if lives == 0:
		emit_signal("win")
