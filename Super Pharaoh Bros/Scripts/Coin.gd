extends Area2D

func _on_Coin_body_entered(body):
	if body.is_in_group("Players"):
		get_tree().call_group("CoinsGUI", "increase_coins")
		queue_free()
