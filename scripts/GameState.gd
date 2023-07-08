extends Node2D

onready var timer_label = $TimerLabel
onready var win_countdown_timer = $WinCountdownTimer

signal win
signal lose

func _ready():
	$GameContainer.connect("no_blocks", self, "_no_blocks_callback")
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
	for child in $Current.get_children():
		child.queue_free()
	$Current.add_child(Globals.current_block[0].instance())
	$CurrentDescription.text = Globals.current_block[1]
	for child in $Next.get_children():
		child.queue_free()
	$Next.add_child(Globals.next_block[0].instance())
	$NextDescription.text = Globals.next_block[1]
