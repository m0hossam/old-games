extends RigidBody2D

func _on_Timer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	if "Enemy" in body.name or "Player" in body.name:
		body.damage()
	queue_free()
