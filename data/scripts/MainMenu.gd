extends Node

var current_selection = 0

onready var container = $MenuItemContainer

func _ready():
	container.add_child(new_menu_item("Play"))
	container.add_child(new_menu_item("About"))
	container.add_child(new_menu_item("Exit"))

func _input(event):
	if event.is_action_pressed("ui_up"):
		if current_selection == 0:
			current_selection = container.get_child_count()-1
		else:
			current_selection -= 1
	elif event.is_action_pressed("ui_down"):
		if current_selection == container.get_child_count()-1:
			current_selection = 0
		else:
			current_selection += 1
	elif event.is_action_pressed("ui_accept"):
		if current_selection == 0:
			Signals.emit_signal("play_activated")
		elif current_selection == 1:
			Signals.emit_signal("about_activated")
		elif current_selection == 2:
			get_tree().quit()

func _process(delta):
	for n in range(0, container.get_child_count(), 1):
		if n == current_selection:
			container.get_children()[n].modulate = Color(1.0, 1.0, 0.0, 1.0)
		else:
			container.get_children()[n].modulate = Color(1.0, 1.0, 1.0, 1.0)

func new_menu_item(text):
	var new_item = Label.new()
	new_item.text = text
	return new_item
