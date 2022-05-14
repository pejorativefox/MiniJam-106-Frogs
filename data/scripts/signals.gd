extends Node


# menu
signal play_activated()
signal about_activated()

# Game
signal mushroom_collected(s_number)
signal last_mushroom_collected(s_number)
signal player_hit_hazard()
signal lap_finished()
signal level_finished()

func _ready():
	print("Signals: Autoloaded.")
