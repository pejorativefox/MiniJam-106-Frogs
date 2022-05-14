extends Control

var current_lap = 1
var elapsed_time = 0.0
var total_laps
var finished = false

onready var lap_times_container = $VBoxContainer/LapTimes
onready var lap_count_label = $VBoxContainer/LapCountLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	total_laps = 4
	Signals.connect("lap_finished", self, "lap_finished")
	for x in range(0, total_laps, 1):
		lap_times_container.add_child(new_lap_time_item(x))


func _process(delta):
	if finished != true:
		elapsed_time += delta
		var current_lap_box = lap_times_container.get_children()[current_lap-1]
		var current_lap_label = current_lap_box.get_children()[1]
		var minutes = elapsed_time / 60.0
		var seconds = fmod(elapsed_time, 60.0)
		var ms = fmod(elapsed_time, 1.0) * 100
		current_lap_label.text = "%02d:%02d:%02d" % [minutes, seconds, ms]
		lap_count_label.text = "Laps (%d/%d)" % [current_lap, total_laps]

func lap_finished():
	if current_lap == total_laps:
			finished = true
	if current_lap < total_laps:
		current_lap += 1
		elapsed_time = 0.0

func new_lap_time_item(lap_num):
	var lap_container = HBoxContainer.new()
	var lap_num_label = Label.new()
	var lap_time_label = Label.new()
	lap_num_label.text = "%d:" % lap_num
	lap_time_label.text = "--:--:--"
	lap_container.add_child(lap_num_label)
	lap_container.add_child(lap_time_label)
	return lap_container
	

func reset():
	current_lap = 1
	for child in lap_times_container.get_children():
		lap_times_container.remove_child(child)
