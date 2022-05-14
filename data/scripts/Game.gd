extends Node

var main_menu
var current_level_id = 1
var current_level = null
var lap_timer = null

var levels = {
	1: "res://Level01.tscn",
	2: "res://Level02.tscn"
	}

func _ready():
	Signals.connect("play_activated", self, "play_activated")
	Signals.connect("level_finished", self, "level_finished")
	main_menu = load("res://MainMenu.tscn").instance()
	self.add_child(main_menu)
	print_debug("Game.gd ready")


func play_activated():
	print_debug("play_activated")
	self.remove_child(main_menu)
	start_level(current_level)

func start_level(level_id):
	# Cleanup old state if we have
	if current_level != null:
		self.remove_child(current_level)
		current_level.queue_free()
		self.remove_child(lap_timer)
		lap_timer.queue_free()
		current_level = null
	# Load and populate this level
	current_level = load(levels[current_level_id]).instance()
	lap_timer = load("res://LapTimer.tscn").instance()
	print(lap_timer.current_lap, "/ ", lap_timer.total_laps)
	var player = load("res://frog.tscn").instance();
	current_level.add_child(player)
	self.add_child(current_level)
	self.add_child(lap_timer)
	get_tree().paused = false

func level_finished():
	print_debug("level_finished")
	get_tree().paused = true
	if levels.has(current_level_id+1):
		#cleanup
		current_level_id += 1
		start_level(current_level_id)
