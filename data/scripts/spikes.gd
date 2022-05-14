extends Area2D

onready var player = get_node("/root/World/Frog")
onready var sploder = get_node("/root/World/BodySploder")

func body_entered(node):
	print_debug("Spikes!")


func _on_Area2D_body_entered(body):
	if body == player and player.godmode == false:
		sploder.splode(player.position)
		player.position.x = 40
		player.position.y = 320
		player.velocity = Vector2.ZERO
		
