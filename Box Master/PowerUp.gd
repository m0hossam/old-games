extends Area2D

func _on_PowerUp_body_entered(body):
	if "Player" in body.name:
		body.power_up()
		queue_free()
