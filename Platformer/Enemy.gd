extends KinematicBody2D

var velocity = Vector2.ZERO
var plr = null
var can_see_plr = false

func _on_PlayerDetectionZone_body_entered(body):
	plr = body
	can_see_plr = true

func _on_PlayerDetectionZone_body_exited(_body):
	can_see_plr = false

func _physics_process(delta):
	if can_see_plr == true:
		var direction = global_position.direction_to(plr.global_position)
		direction.y = 0
		velocity = velocity.move_toward(200 * direction, 200 * delta)
		velocity.y += 20
		velocity = move_and_slide(velocity)
	else:
		velocity.y += 20
		velocity.x = 0
		velocity = move_and_slide(velocity)
