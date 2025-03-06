extends KinematicBody2D

var ready = false
var speed = 300
var direction = Vector2.ZERO

func _physics_process(delta):
	if ready:
		var collision = move_and_collide(direction*speed*delta)
		if collision:
			if collision.collider.name == "Player" or "Enemy" in collision.collider.name:
				collision.collider.damage()
			queue_free()

#dir = Vector2, air = bool
func update_direction(dir, air):
	direction = dir
	ready = true
	if air:
		$ColorRect.color = Color("646464")
		speed = 100
