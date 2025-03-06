extends Area2D

func _on_AmmoPowerup_body_entered(body):
	if body.name == "Player":
		body.ammo()
		queue_free()
