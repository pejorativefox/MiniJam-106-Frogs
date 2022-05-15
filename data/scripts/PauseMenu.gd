extends CanvasLayer

var selected = 0

func _input(event):
#	if Input.is_action_pressed("ui_cancel"):
#		Signals.emit_signal("unpause_level")
	if Input.is_action_pressed("ui_accept"):
		if selected == 0:
			Signals.emit_signal("unpause_level")
		else:
			Signals.emit_signal("unpause_level")
			Signals.emit_signal("exit_level")
	if Input.is_action_pressed("ui_down"):
		selected = 1
	elif Input.is_action_pressed("ui_up"):
		selected = 0
	
func _process(delta):
	$Control/ResumeLabel.modulate = Color(1,1,1,1)
	$Control/ExitLabel.modulate = Color(1,1,1,1)
	if selected == 0:
		$Control/ResumeLabel.modulate = Color(1,1,0,1)
	else:
		$Control/ExitLabel.modulate = Color(1,1,0,1)
		
	
func _ready():
	pass
