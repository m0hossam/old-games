extends KinematicBody2D

var velocity = Vector2(512, 0)
var collision
var scoreboard

func _physics_process(delta):
	
	collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.collider.name != "Boundaries":
			collision.collider.queue_free()
			scoreboard.increment_score()
		queue_free()
