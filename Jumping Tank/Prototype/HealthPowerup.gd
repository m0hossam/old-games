extends Area2D

func _on_HealthPowerup_body_entered(body):
	if body.name == "Player":
		body.heal()
		queue_free()
