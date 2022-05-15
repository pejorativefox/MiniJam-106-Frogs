extends Node

var main_menu
var current_level_id = 1
var current_level = null
var lap_timer = null
var pause_menu = null

var levels = {
	1: "res://Level01.tscn",
	2: "res://Level02.tscn",
	3: "res://Level03.tscn",
	4: "res://Level04.tscn",
	5: "res://Level07.tscn",
	6: "res://Level08.tscn"
	}

func _ready():
	Signals.connect("play_activated", self, "play_activated")
	Signals.connect("level_finished", self, "level_finished")
	Signals.connect("exit_level", self, "exit_level")
	Signals.connect("pause_level", self, "pause_level")
	Signals.connect("unpause_level", self, "unpause_level")
	Signals.connect("next_level", self, "next_level")
	Signals.connect("player_off_map", self, "player_off_map")
	Signals.connect("post_win", self, "post_win")
	Signals.connect("menu_activated_sound", self, "menu_activated_sound")
	Signals.connect("menu_navigated_sound", self, "menu_navigated_sound")
	main_menu = load("res://MainMenu.tscn").instance()
	self.add_child(main_menu)
	add_transition()
	print_debug("Game.gd ready")

func menu_activated_sound():
	$Audio/Confirm.play()

func menu_navigated_sound():
	$Audio/CursorMove.play()

func play_activated():
	print_debug("play_activated")
	self.remove_child(main_menu)
	main_menu.queue_free()
	start_level(current_level)
	
	
func add_transition():
	add_child(load("res://FadeTransition.tscn").instance())
	
func delete_level():
	if current_level != null:
		self.remove_child(current_level)
		current_level.queue_free()
		self.remove_child(lap_timer)
		lap_timer.queue_free()
		current_level = null

func start_level(level_id):
	# Cleanup old state if we have
	delete_level()
	# Load and populate this level
	current_level = load(levels[current_level_id]).instance()
	lap_timer = load("res://LapTimer.tscn").instance()
	print(lap_timer.current_lap, "/ ", lap_timer.total_laps)
	var player = load("res://frog.tscn").instance();
	current_level.add_child(player)
	self.add_child(current_level)
	self.add_child(lap_timer)
	var start_node = current_level.get_node("Start")
	player.position = start_node.position
	get_tree().paused = false
	add_transition()

func level_finished():
	print("level_finished")
	get_tree().paused = true
	add_child(load("res://StageClear.tscn").instance())
	

func next_level():
	print("next level")
	if levels.has(current_level_id+1):
		#cleanup
		current_level_id += 1
		start_level(current_level_id)
	else:
		game_win()

func pause_level():
	print("pause_level signaled")
	pause_menu = load("res://PauseMenu.tscn").instance()
	add_child(pause_menu)
	get_tree().set_input_as_handled()
	get_tree().paused = true

func unpause_level():
	print("unpause_level signaled")
	remove_child(pause_menu)
	pause_menu.queue_free()
	get_tree().set_input_as_handled()
	get_tree().set_input_as_handled()
	get_tree().set_input_as_handled()
	get_tree().set_input_as_handled()
	get_tree().set_input_as_handled()
	get_tree().set_input_as_handled()
	get_tree().paused = false

func exit_level():
	delete_level()
	main_menu = load("res://MainMenu.tscn").instance()
	self.add_child(main_menu)
	current_level_id = 1
	add_transition()

func player_off_map():
	var player = current_level.get_node("Frog")
	var start = current_level.get_node("Start")
	player.velocity = Vector2.ZERO
	player.position = start.position

func game_win():
	delete_level()
	get_tree().set_input_as_handled()
	print("clear input")
#	get_tree().paused = false
	self.add_child(load("res://GameWin.tscn").instance())
	get_tree().set_input_as_handled()
	
func post_win():
	delete_level()
	main_menu = load("res://MainMenu.tscn").instance()
	self.add_child(main_menu)
	get_tree().paused = false
	current_level_id = 1
	add_transition()
