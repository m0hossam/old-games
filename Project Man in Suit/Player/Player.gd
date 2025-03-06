extends KinematicBody2D

#can be edited in Inspector
#are used for parameters of movement
export var MAX_SPEED = 85
export var ACCELERATION = 250
export var FRICTION = 500

#states of motion
enum {
	MOTION,
	ATTACK
}

#default state is MOTION not ATTACK
var state = MOTION
var velocity = Vector2.ZERO

#getting access to nodes and a property of one node whenever the scene is loaded
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

#matching states to their corresponding functions
func _physics_process(delta):
	match state:
		MOTION:
			move_state(delta)
			
		ATTACK:
			pass

#function of motion
func move_state(delta):
	var velocity_direction = Vector2.ZERO
	velocity_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#getting a unit vector in the direction of velocity
	velocity_direction = velocity_direction.normalized()
	
	#if we're pressing move buttons to move
	if velocity_direction != Vector2.ZERO:
		#sets the direction of the Idle and Move's blend positions-
		#-to the direction of the velocity to match the right-
		#-animation with the movement
		animationTree.set("parameters/Idle/blend_position", velocity_direction)
		animationTree.set("parameters/Move/blend_position", velocity_direction)
		#transitions to the Move blendspace
		animationState.travel("Move")
		#makes the Player move in direction of-
		#-velocity_direction with a max magnitude MAX_SPEED-
		#-and a rate of change ACCELERATION per every frame(delta)
		velocity = velocity.move_toward(velocity_direction * MAX_SPEED, ACCELERATION * delta)
	#if velocity = zero, we're not moving
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	#bult-in function that makes Player actually move with the before-mentioned velocity-
	#-and slide when in collision with other bodies instead of abruptly stopping
	velocity = move_and_slide(velocity)
