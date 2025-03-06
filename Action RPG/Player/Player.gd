extends KinematicBody2D #library of object's type (inherits all of its properties)

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

export var MAX_SPEED = 80
export var ACCELERATION = 500
export var ROLL_SPEED = 125
export var FRICTION = 500

enum {
	MOVE,
	ROLL,
	ATTACK
} #only one state at a time

var state = MOVE
var roll_vector = Vector2.DOWN #default rolling direction
var velocity = Vector2.ZERO #velocity built-in 2D-vector, has several useful functions like clapmed(), normalized()
var stats = PlayerStats #contains stored health of player

onready var animationPlayer = $AnimationPlayer #onready waits for the node "AnimationPlayer" to load before usage and $ calls the node
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback") #gets value of property
onready var swordHitbox = $HitboxPivot/SwordHitbox #gives 'swordHitbox' access to the SwordHitbox instance to use the var 'knockback_vector' inside its script later
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	randomize() #gives different seeds for random generators everytime we run the game
	stats.connect("no_health", self, "queue_free") #accesses PlayerStats
	animationTree.active = true #instead of playing the animation all the time
	swordHitbox.knockback_vector = roll_vector #knockback_vector is declared in SwordHitbox's script

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
			
		ROLL:
			roll_state()
			
		ATTACK:
			attack_state()
	
func move_state(delta): #function repsonsible for moving animation and speed
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO: #animation that plays when we're moving
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)	
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else: #this is when we're not moving
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) #slows down object?
		
	move()

	if Input.is_action_just_pressed("attack"): #transition to the attack state when any of the attack keys(Input Map, Project Settings) are pressed
		state = ATTACK
		
	if Input.is_action_just_pressed("roll"): #transition to roll state when roll keys are pressed
		state = ROLL
	
func roll_state():
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()
		
func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func move():
	velocity = move_and_slide(velocity) #built-in function that allows sliding when colliding with walls instead of sticking, doesn't require (delta)
	
func roll_animation_finished(): #gets called when roll animation finishes
	velocity = velocity * 0.8
	state = MOVE
	
func attack_animation_finished(): #changes state when attacking finishes
	state = MOVE

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)


func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")
