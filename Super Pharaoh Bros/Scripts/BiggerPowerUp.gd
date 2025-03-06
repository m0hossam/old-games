extends Area2D

func _on_BiggerPowerUp_body_entered(body):
	if body.is_in_group("Players"):
		body.get_bigger()
		queue_free()
