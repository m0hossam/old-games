extends KinematicBody2D

const GRAVITY = 20
const MAX_SPEED = 300
const ACCELERATION = 200
const UP = Vector2(0, -1)
const JUMP_SPEED = -500

var velocity = Vector2.ZERO

func _physics_process(_delta):
	#Movement:-
	
	velocity.y += GRAVITY
	
	if Input.is_action_pressed("move_right"):
		velocity.x = min(velocity.x + ACCELERATION, MAX_SPEED) 
	elif Input.is_action_pressed("move_left"):
		velocity.x = max(velocity.x - ACCELERATION, -MAX_SPEED)
	else:
		velocity.x = 0
	
	if is_on_floor() and Input.is_action_just_pressed("move_up"):
		velocity.y = JUMP_SPEED
	
	velocity = move_and_slide(velocity, UP)
