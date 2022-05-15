extends Node


# menu
signal play_activated()
signal about_activated()

#sounds
signal menu_activated_sound()
signal menu_navigated_sound()
signal start_menu_music()
signal stop_menu_music()

signal picked_coin_sound()
signal fanfare_sound()
signal jump_sound()

# Game
signal mushroom_collected(s_number)
signal last_mushroom_collected(s_number)
signal player_hit_hazard()
signal lap_finished()
signal level_finished()
signal pause_level()
signal next_level()
signal unpause_level()
signal exit_level()
signal player_off_map()
signal post_win()

func _ready():
	print("Signals: Autoloaded.")
