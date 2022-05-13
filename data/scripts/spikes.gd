extends Area2D

onready var player = get_node("/root/Root/Frog")

func body_entered(node):
	print_debug("Spikes!")


func _on_Area2D_body_entered(body):
	if body == player:
		print_debug("its the player!")
		print_debug("Spikes!")
		player.position.x = 40
		player.position.y = 320
		player.velocity = Vector2.ZERO
