extends Node

export(int) var sequence_number
export(bool) var last

onready var player = get_node("/root/Root/Frog")
onready var sprite = $Sprite
onready var area = $Area2D

signal mushroom_collected(s_number)

func _ready():
	connect("mushroom_collected", self, "mushroom_collected")
	if sequence_number == 0:
		set_ready()
	else:
		set_not_ready()

func mushroom_collected(s_number):
	print_debug("mushroom_collected: ", s_number, sequence_number)
	if s_number == sequence_number:
		set_not_ready()
	elif s_number+1 == sequence_number:
		set_ready()

func set_ready():
	area.monitoring = true;
	sprite.self_modulate = Color(1, 1, 1, 1)

func set_not_ready():
	sprite.self_modulate = Color(1, 1, 1, 0.3)

func _on_Area2D_body_entered(body):
	if body == player:
		print_debug("Player hit shroom: ", sequence_number)
		emit_signal("mushroom_collected", sequence_number)
