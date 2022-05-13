extends Node


var movementVector = Vector2(0, 0);

func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if Input.is_action_pressed("jump"):
		movementVector += Vector2(0, -1);
		print_debug("jump!");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
