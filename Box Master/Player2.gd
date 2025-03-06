extends KinematicBody2D

const UP = Vector2(0, -1)

export var GRAVITY = 10
export var MAX_SPEED = 250
export var ACCELERATION = 150
export var JUMP_SPEED = -500
export var inertia = 300
export var kick_power = 300

var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var timer = $Timer

func _physics_process(_delta):
	 
	velocity.y += GRAVITY
	
	#Moving Left and Right:-
	
	if Input.is_action_pressed("ui2_right"):
		velocity.x = min(velocity.x + ACCELERATION, MAX_SPEED) #when max value is exceeded, it returns to the min value
	elif Input.is_action_pressed("ui2_left"):
		velocity.x = max(velocity.x - ACCELERATION, -MAX_SPEED) #when min value is exceeded, it returns to the max value
	else:
		velocity.x = 0
		
	#Jumping:-
	
	if is_on_floor() and Input.is_action_just_pressed("ui2_up"):
		velocity.y = JUMP_SPEED
	
	#Shooting Frames:-
	
	if Input.is_action_pressed("ui2_shoot"):
		var ball_pos = get_parent().find_node("Ball").global_position.x
		if global_position.x > ball_pos:
			sprite.frame = 2
		elif global_position.x < ball_pos:
			sprite.frame = 1
	if Input.is_action_just_released("ui2_shoot"):
		sprite.frame = 0
		
	############	
	velocity = move_and_slide(velocity, UP, false, 4, 0.785398, false)
	############
	
	#Collision With Ball:-
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.name == "Ball":
			collision.collider.apply_central_impulse(-collision.normal * inertia)
			

func _on_RightLeg_body_entered(body):
	if body.name == "Ball" and Input.is_action_pressed("ui2_shoot"):
		body.apply_central_impulse(Vector2(velocity.normalized().x, -0.75) * kick_power)

func _on_LeftLeg_body_entered(body):
	if body.name == "Ball" and Input.is_action_pressed("ui2_shoot"):
		body.apply_central_impulse(Vector2(velocity.normalized().x, -0.75) * kick_power)

func _on_Head_body_entered(body): #Headers
	if body.name == "Ball":
		var direction = global_position.direction_to(body.global_position)
		body.apply_central_impulse(direction * kick_power)

func power_up():
	kick_power = 600
	timer.start()

func _on_Timer_timeout():
	kick_power = 300
