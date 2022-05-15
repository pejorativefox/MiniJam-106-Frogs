extends Control

func _ready():
	$AnimationPlayer.play("fade") 


func _on_Timer_timeout():
	get_parent().remove_child(self)
