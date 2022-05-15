extends Node

export(int) var sequence_number
export(bool) var last


func _ready():
	Signals.connect("mushroom_collected", self, "mushroom_collected")
	Signals.connect("last_mushroom_collected", self, "last_mushroom_collected")
	if sequence_number == 0:
		set_ready()
	else:
		set_not_ready()

func mushroom_collected(s_number):
	if s_number == sequence_number:
		set_not_ready()
		Signals.emit_signal("picked_coin_sound")
		if last:
			Signals.emit_signal("last_mushroom_collected")
	elif s_number+1 == sequence_number:
		set_ready()

func last_mushroom_collected():
	print("last_mushroom_collected")
	if sequence_number == 0:
		Signals.emit_signal("lap_finished")
		set_ready();

func set_ready():
	$Area2D/CollisionShape2D.set_deferred("disabled", false);
	$Sprite.self_modulate = Color(1, 1, 1, 1)

func set_not_ready():
	$Area2D/CollisionShape2D.set_deferred("disabled", true);
	$Sprite.self_modulate = Color(1, 1, 1, 0.1)

func _on_Area2D_body_entered(body):
	var player = get_node("/root/Game/LevelRoot/Frog")
	if body == player:
		Signals.emit_signal("mushroom_collected", sequence_number)
