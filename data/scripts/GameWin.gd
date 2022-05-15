extends CanvasLayer

var elapsed = 0.0

func _input(event):
	if elapsed < 5:
		pass
	else:
		if Input.is_action_pressed("ui_accept"):
			print("GAME WIN")
			Signals.emit_signal("post_win")
			get_parent().remove_child(self)

func _ready():
	$Control/Label3.visible == false

func _process(delta):
	elapsed += delta
	if $Control/Label3.visible == false and elapsed > 5:
		$Control/Label3.visible = true
