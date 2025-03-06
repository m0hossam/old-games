extends KinematicBody2D

const ACCELERATION = 300
const FRICTION = 500
const MAX_SPEED = 200

var player
var start_shooting = false
var velocity = Vector2.ZERO
var velocity_direction = Vector2.ZERO

#Laser:
var hit = null
var can_shoot = true
export var beam_duration = 1.5
export var cooldown = 0.5
	
func _physics_process(delta):
	move(delta)
	
	if start_shooting:
		shoot()
	
	if hit: #updating beam
		hit = cast_beam()
	
func move(delta):
	if velocity_direction != Vector2.ZERO:
		velocity_direction = global_position.direction_to(player.global_position)
		rotation_degrees = velocity_direction.angle() * 57.2957795
		velocity = velocity.move_toward(MAX_SPEED * velocity_direction, ACCELERATION * delta)
	elif velocity_direction == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)

func shoot():
	can_shoot = false
	hit = cast_beam()
	yield(get_tree().create_timer(beam_duration), "timeout")
	$Line2D.remove_point(1)
	hit = null
	yield(get_tree().create_timer(cooldown), "timeout")
	can_shoot = true

func cast_beam():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray($Position2D.global_position, $Position2D.global_position + transform.x * 1000, [self])
	if result:
		if !hit:
			$Line2D.add_point(transform.xform_inv(result.position))
		else:
			$Line2D.set_point_position(1, transform.xform_inv(result.position))
	return result
	
func damage():
	if $ProgressBar.value == 10:
		queue_free()
	$ProgressBar.value -= 10

func _on_Zone_body_entered(body):
	start_shooting = true
	player = body
	velocity_direction = global_position.direction_to(player.global_position)

func _on_Zone_body_exited(_body):
	start_shooting = false
	player = null
	velocity_direction = Vector2.ZERO
