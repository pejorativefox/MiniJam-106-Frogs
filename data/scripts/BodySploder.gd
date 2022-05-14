extends Node2D

func _ready():
	$HeadParticles.emitting = false
	$FrontLegParticles.emitting = false
	$RearLegParticles.emitting = false
	$BloodParticles.emitting = false

func splode(position):
	self.position = position
	$AnimationPlayer.play("splode")
