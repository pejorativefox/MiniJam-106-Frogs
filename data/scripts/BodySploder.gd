extends Node2D

func _ready():
	$HeadParticles.emitting = false
	$FrontLegParticles.emitting = false
	$RearLegParticles.emitting = false
	$BloodParticles.emitting = false
	$SplatSpund

func splode(position):
	print("splode: ", position)
	self.position = position
	$AnimationPlayer.play("splode")
	$SplatSpund.play()


func _on_Timer_timeout():
	self.get_parent().remove_child(self)
