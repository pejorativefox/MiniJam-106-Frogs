extends Area2D

func _on_Area2D_body_entered(body):
	var player = get_node("/root/Game/LevelRoot/Frog")
	if body == player and player.godmode == false:
		Signals.emit_signal("player_hit_hazard")
		
