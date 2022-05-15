extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	var player = get_node("/root/Game/LevelRoot/Frog")
	if body == player and player.godmode == false:
		Signals.emit_signal("player_hit_hazard")
