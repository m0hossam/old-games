extends KinematicBody2D

export var right = true

var enemies = ["Enemy", "Enemy2", "Enemy3", "Enemy4", "Enemy5",
 "Enemy6", "Enemy7", "Enemy8", "Enemy9", "Enemy10"]
var collision = null
var velocity_right = Vector2(750, 0)
var velocity_left = Vector2(-750, 0)

func _physics_process(delta):
	if right == true:
		collision = move_and_collide(velocity_right * delta)
	elif right == false:
		collision = move_and_collide(velocity_left * delta)
	if collision:
		if collision.collider.name in enemies:
			collision.collider.queue_free()
		queue_free()
