extends KinematicBody2D

const ACCELERATION = 500
const FRICTION = 500
const MAX_SPEED = 300

var projectile = preload("res://Scenes/Bullet.tscn")
var bullet_speed = 600
var velocity = Vector2.ZERO
var shoot_direction = Vector2.ZERO

func _process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("ui_mouse_left"):
		shoot_bullet()
		
func _physics_process(delta):
	move(delta)
		
func move(delta):
	var velocity_direction = Vector2.ZERO
	velocity_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if velocity_direction != Vector2.ZERO:
		velocity = velocity.move_toward(MAX_SPEED * velocity_direction, ACCELERATION * delta)
	elif velocity_direction == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

func shoot_bullet():
	var projectile_instance = projectile.instance()
	projectile_instance.position = $Position2D.global_position
	projectile_instance.rotation_degrees = rotation_degrees
	projectile_instance.apply_impulse(Vector2.ZERO, Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().get_child(0).add_child(projectile_instance)

func damage():
	if $ProgressBar.value == 10:
		queue_free()
	$ProgressBar.value -= 10
