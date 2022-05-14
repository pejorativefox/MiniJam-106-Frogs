extends KinematicBody2D

const GRAVITY = 400.0
const WALK_SPEED = 50.0
const ACCEL = 1028
const MAX_SPEED = 256
const FRICTION = 1
const AIR_RESIST = 0.02
const JUMP_FORCE = 350

var velocity = Vector2()

onready var player_sprite = $Sprite

func _ready():
	pass # Replace with function body.


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_F:
				OS.window_fullscreen = !OS.window_fullscreen
			if event.scancode == KEY_ESCAPE:
				get_tree().quit()


func _physics_process(delta):
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if x_input != 0:
		velocity.x += x_input * ACCEL * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		player_sprite.flip_h = x_input < 0
		
	else:
		pass
		
	velocity.y += GRAVITY * delta
	
	if is_on_floor():
		if x_input == 0:
			velocity.x = lerp(velocity.x, 0, FRICTION)
			player_sprite.play("idle")
		else:
			player_sprite.play("walk")
		if Input.is_action_just_pressed("jump"):
			velocity.y = -JUMP_FORCE
	else:
		player_sprite.play("jump")
		if Input.is_action_just_released("jump") and velocity.y < -JUMP_FORCE/2:
			velocity.y = -JUMP_FORCE/2
			
		if x_input == 0:
			velocity.x = lerp(velocity.x, 0, AIR_RESIST)
			
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	# check off screen
	if position.y > 600:
		position.x = 40
		position.y = 320


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func splode():
	$BodySploder.splode()
