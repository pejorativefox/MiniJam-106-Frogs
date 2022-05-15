extends CanvasLayer

var selected = 0

func _input(event):
#	if Input.is_action_pressed("ui_cancel"):
#		Signals.emit_signal("unpause_level")
	if Input.is_action_pressed("ui_accept"):
		Signals.emit_signal("menu_activated_sound")
		if selected == 0:
			Signals.emit_signal("unpause_level")
		else:
			Signals.emit_signal("unpause_level")
			Signals.emit_signal("exit_level")
	if Input.is_action_pressed("ui_down"):
		selected = 1
		Signals.emit_signal("menu_navigated_sound")
	elif Input.is_action_pressed("ui_up"):
		selected = 0
		Signals.emit_signal("menu_navigated_sound")
	
func _process(delta):
	$Control/ResumeLabel.modulate = Color(1,1,1,1)
	$Control/ExitLabel.modulate = Color(1,1,1,1)
	if selected == 0:
		$Control/ResumeLabel.modulate = Color(1,1,0,1)
	else:
		$Control/ExitLabel.modulate = Color(1,1,0,1)
		
	
func _ready():
	pass
