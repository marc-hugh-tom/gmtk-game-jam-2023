extends Node2D

const menu_scene = preload("res://scenes/MainMenu.tscn")
const credits_scene = preload("res://scenes/Credits.tscn")
const win_scene = preload("res://scenes/Win.tscn")
const scene_transition = preload("res://scenes/SceneTransition.tscn")
const game_scene = preload("res://scenes/GameState.tscn")

const CENTRE = Vector2(512, 300)

func _ready():
	pause_mode = PAUSE_MODE_PROCESS
	deferred_start_menu()

# Start first level
func play():
	initiate_fade_to_black("deferred_start_level")

func deferred_start_level():
	clear_scene()
	var game = game_scene.instance()
	game.connect("win", self, "start_win_screen")
	add_child(game)
	initiate_fade_to_transparent("remove_transition_overlay")

# MainMenu
func start_menu():
	if not has_node("SceneTransition"):
		initiate_fade_to_black("deferred_start_menu")

func deferred_start_menu():
	clear_scene()
	var menu = menu_scene.instance()
	menu.connect("play", self, "play")
	menu.connect("start_credits", self, "start_credits")
	add_child(menu)
	initiate_fade_to_transparent("remove_transition_overlay")

# CreditsState
func start_credits():
	if not has_node("SceneTransition"):
		initiate_fade_to_black("deferred_start_credits")

func deferred_start_credits():
	clear_scene()
	var credits = credits_scene.instance()
	credits.connect("start_menu", self, "start_menu")
	add_child(credits)
	initiate_fade_to_transparent("remove_transition_overlay")

# WinScreen
func start_win_screen():
	if not has_node("SceneTransition"):
		initiate_fade_to_black("deferred_start_win_screen")

func deferred_start_win_screen():
	clear_scene()
	var win = win_scene.instance()
	win.connect("start_menu", self, "start_menu")
	add_child(win)
	initiate_fade_to_transparent("remove_transition_overlay")

# Transition functions
func clear_scene():
	for child in get_children():
		child.free()

func initiate_fade_to_black(input_callback_str):
	var transition = scene_transition.instance()
	transition.set_to_transparent()
	transition.connect("transition_finished", self, "transition_finished_callback")
	add_child(transition)
	transition.fade_to_black(input_callback_str, CENTRE)

func initiate_fade_to_transparent(input_callback_str):
	var transition = scene_transition.instance()
	transition.set_to_black()
	transition.connect("transition_finished", self, "transition_finished_callback")
	add_child(transition)
	transition.fade_to_transparent(input_callback_str, CENTRE)

func transition_finished_callback(callback_str):
	call_deferred(callback_str)

func remove_transition_overlay():
	$SceneTransition.queue_free()
