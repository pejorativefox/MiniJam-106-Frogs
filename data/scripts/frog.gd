extends KinematicBody2D

const GRAVITY = 400.0
const WALK_SPEED = 50.0
const ACCEL = 1028
const MAX_SPEED = 256
const FRICTION = 1
const AIR_RESIST = 0.02
const JUMP_FORCE = 360

export(bool) var godmode = false

var velocity = Vector2()
var resolution

onready var player_sprite = $Sprite
var sploder = load("res://BodySploder.tscn")

func _ready():
	resolution = Vector2(get_viewport().size.x/2, get_viewport().size.y/2+40)
	Signals.connect("player_hit_hazard", self, "player_hit_hazard")


func _unhandled_input(event):
	if Input.is_action_pressed("ui_select"):
		Signals.emit_signal("pause_level")
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_F:
				OS.window_fullscreen = !OS.window_fullscreen
			if event.scancode == KEY_ESCAPE:
				Signals.emit_signal("pause_level")



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
	if position.y > resolution.y:
		Signals.emit_signal("player_off_map")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func player_hit_hazard():
	var body_sploder = sploder.instance()
	body_sploder.splode(position)
	self.get_parent().add_child(body_sploder)
	var start = self.get_parent().get_node("Start")
	position = start.position
	velocity = Vector2.ZERO
