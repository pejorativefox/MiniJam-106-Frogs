extends CanvasLayer


func _input(event):
	if Input.is_action_pressed("ui_accept"):
		Signals.emit_signal("next_level")
		get_parent().remove_child(self)

func _ready():
	var lap_timer = get_node("../LapTimer")
	get_parent().remove_child(lap_timer)
	self.add_child(lap_timer)
