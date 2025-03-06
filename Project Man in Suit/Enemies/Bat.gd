extends KinematicBody2D

#Parameters of movement:
export var MAX_SPEED = 50
export var ACCELERATION = 300
export var FRICTION = 200

#States of motion:
enum {
	IDLE,
	CHASE
}


var state = CHASE
var velocity = Vector2.ZERO

onready var animatedSprite = $AnimatedSprite
onready var playerDetectionZone = $PlayerDetectionZone

func _ready():
	state = IDLE #default starting state

func _physics_process(delta):
	match state:
		IDLE:
			#Slowing down after movement:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			#Function that searches for player collision with the PlayerDetectionZone:
			seek_player()
		CHASE:
			var playerBody = playerDetectionZone.PlayerBody #colliding area
			if playerBody != null: #if there is area colliding
				accelerate_towards_body(playerBody.global_position, delta) #move towards the position of the colliding area
			else: #if there's no area colliding
				state = IDLE
	velocity = move_and_slide(velocity) #bult-in moving function

#responsible for direction of movement towards body:
func accelerate_towards_body(body, delta):
	var direction = global_position.direction_to(body) #gets unit vector from position of parent to positon of (body)
	velocity = velocity.move_toward(MAX_SPEED * direction, ACCELERATION * delta) #accelerate to max-speed in direction of "direction" unit vector by an acceleration rate
	animatedSprite.flip_h = velocity.x < 0 #if velocity's x coordinate is negative, then bat is moving left, then we flip the AnimatedSprite horizontally
	
#searches for the player continuously inside _physics_process()	
func seek_player():
	if playerDetectionZone.can_see_player(): #a function inside PlayerDetectionZone that returns true/false
		state = CHASE
