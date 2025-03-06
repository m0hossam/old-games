extends KinematicBody2D

var velocity = Vector2(-100, 0)
var collision

func _physics_process(delta):
	collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.name == "Player":
			get_parent().get_node("GUI/Restart").visible = true
			collision.collider.queue_free()
		queue_free()
