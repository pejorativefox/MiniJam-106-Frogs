extends KinematicBody2D

const GRAVITY = 200.0
const WALK_SPEED = 50.0

var velocity = Vector2()

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if Input.is_action_pressed("jump"):
		print_debug("jump!");
	if Input.is_action_pressed("move_left"):
		velocity.x = -WALK_SPEED
	if Input.is_action_pressed("move_right"):
		velocity.x = WALK_SPEED


func _physics_process(delta):
	
	velocity.y += gravity * delta

	#var motion = velocity * delta
	print_debug(velocity)
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	#move_and_collide(motion)
	#move_and_slide(motion, Vector2(0, -1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
