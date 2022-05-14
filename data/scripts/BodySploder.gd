extends Node2D

func _ready():
	$HeadParticles.emitting = false
	$FrontLegParticles.emitting = false
	$RearLegParticles.emitting = false
	$BloodParticles.emitting = false

func splode(position):
	print("splode: ", position)
	self.position = position
	$AnimationPlayer.play("splode")


func _on_Timer_timeout():
	self.get_parent().remove_child(self)
