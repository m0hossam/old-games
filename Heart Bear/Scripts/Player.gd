extends CharacterBody2D


const GROUND_SPEED = 175.0
const AIR_SPEED = 150.0
const JUMP_VELOCITY = -350.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_jump = true
var is_jump_pressed = false
var current_pos

# Get coordinates of worlds:
@onready var fall_pos = get_parent().find_child("FallWorld").position
@onready var summer_pos = get_parent().find_child("SummerWorld").position
@onready var spring_pos = get_parent().find_child("SpringWorld").position
@onready var winter_pos = get_parent().find_child("WinterWorld").position


func _ready():
	current_pos = summer_pos


func _physics_process(delta):
	var speed

	# Coyote Time:
	if is_on_floor():
		can_jump = true
		# Buffer Jump:
		if is_jump_pressed:
			velocity.y = JUMP_VELOCITY
			can_jump = false

	# Jump:
	if Input.is_action_just_pressed("jump"):
		is_jump_pressed = true
		if $BufferJumpTimer.is_stopped() and is_jump_pressed:
			$BufferJumpTimer.start()
		if can_jump:
			velocity.y = JUMP_VELOCITY
			can_jump = false

	# Gravity:
	if not is_on_floor():
		if $CoyoteTimer.is_stopped() and can_jump:
			$CoyoteTimer.start()
		velocity.y += gravity * delta
		speed = AIR_SPEED
	else:
		speed = GROUND_SPEED

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func play_damage_flash():
	$AnimationPlayer.play("damage_flash")


func _on_coyote_timer_timeout():
	can_jump = false


func _on_buffer_jump_timer_timeout():
	is_jump_pressed = false


func _on_summer_button_pressed():
	if current_pos != summer_pos:
		get_tree().call_group("WorldButtons", "disable_travel")
		$TravelCooldown.start()
		position = position - current_pos + summer_pos
		current_pos = summer_pos


func _on_winter_button_pressed():
	if current_pos != winter_pos:
		get_tree().call_group("WorldButtons", "disable_travel")
		$TravelCooldown.start()
		position = position - current_pos + winter_pos
		current_pos = winter_pos


func _on_spring_button_pressed():
	if current_pos != spring_pos:
		get_tree().call_group("WorldButtons", "disable_travel")
		$TravelCooldown.start()
		position = position - current_pos + spring_pos
		current_pos = spring_pos


func _on_fall_button_pressed():
	if current_pos != fall_pos:
		get_tree().call_group("WorldButtons", "disable_travel")
		$TravelCooldown.start()
		position = position - current_pos + fall_pos
		current_pos = fall_pos


func _on_travel_cooldown_timeout():
	get_tree().call_group("WorldButtons", "enable_travel")
