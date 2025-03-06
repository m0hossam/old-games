extends KinematicBody2D

const ACCELERATION = 300
const FRICTION = 500
const MAX_SPEED = 200

var player
var can_shoot = false
var cooldown = false
var projectile = preload("res://Scenes/Bullet.tscn")
var projectile_speed = 600
var velocity = Vector2.ZERO
var velocity_direction = Vector2.ZERO

func _process(_delta):
	if can_shoot and !cooldown:
		shoot()
		cooldown = true
		$Timer.start()

func _physics_process(delta):
	move(delta)
	
func move(delta):
	if velocity_direction != Vector2.ZERO:
		velocity_direction = global_position.direction_to(player.global_position)
		rotation_degrees = velocity_direction.angle() * 57.2957795
		velocity = velocity.move_toward(MAX_SPEED * velocity_direction, ACCELERATION * delta)
	elif velocity_direction == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)

func shoot():
	var projectile_instance = projectile.instance()
	projectile_instance.position = $Position2D.global_position
	projectile_instance.rotation_degrees = rotation_degrees
	projectile_instance.apply_impulse(Vector2.ZERO, Vector2(projectile_speed, 0).rotated(rotation))
	get_tree().get_root().get_child(0).add_child(projectile_instance)

func _on_Zone_body_entered(body):
	can_shoot = true
	player = body
	velocity_direction = global_position.direction_to(player.global_position)

func _on_Zone_body_exited(_body):
	can_shoot = false
	velocity_direction = Vector2.ZERO

func _on_Timer_timeout():
	cooldown = false

func damage():
	if $ProgressBar.value == 10:
		queue_free()
	$ProgressBar.value -= 10
