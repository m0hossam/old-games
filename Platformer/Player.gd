extends KinematicBody2D

const LASER = preload("res://Laser.tscn")

const GRAVITY = 20
const MAX_SPEED = 300
const ACCELERATION = 500
const UP = Vector2(0, -1)
const JUMP_SPEED = -500

var velocity = Vector2.ZERO

onready var healthbar = get_parent().find_node("GUI").get_child(0)
onready var container = $Container
onready var shootPointRight = $ShootPointRight
onready var shootPointLeft = $ShootPointLeft
onready var timer = $Timer
onready var sprite2D = $Sprite2D

func _physics_process(_delta):
	
	#Movement:-
	
	velocity.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + ACCELERATION, MAX_SPEED) #when max value is exceeded, it returns to the min value
		sprite2D.frame = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - ACCELERATION, -MAX_SPEED) #when min value is exceeded, it returns to the max value
		sprite2D.frame = 1
	else:
		velocity.x = 0
	
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_SPEED
	
	velocity = move_and_slide(velocity, UP)
	
	#Attacking:-
	
	if Input.is_action_just_pressed("ui_attack"):
		var laser = LASER.instance()
		get_child(6).add_child(laser) #Container should be last child
		if sprite2D.frame == 0:
			laser.right = true
			laser.position = shootPointRight.global_position
		elif sprite2D.frame == 1:
			laser.right = false
			laser.position = shootPointLeft.global_position

func _on_PlayerHurtbox_body_entered(_body):
	if healthbar.value != 0:
		timer.start()
		healthbar.value -= 10
		if healthbar.value == 0:
			queue_free()
	elif healthbar.value == 0:
		queue_free()

func _on_PlayerHurtbox_body_exited(_body):
	timer.stop()

func _on_Timer_timeout():
	healthbar.value -= 10
	if healthbar.value == 0:
		queue_free()
