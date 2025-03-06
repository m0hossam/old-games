extends Area2D

var PlayerBody = null

#returns true if there's a body colliding,
#returns false if there's no body colliding:
func can_see_player():
	return PlayerBody != null

#signal when body enters collision zone, assign the colliding area to the PlayerBody variable
func _on_PlayerDetectionZone_body_entered(body):
	PlayerBody = body

#delete the value of the variable when body exits zone
func _on_PlayerDetectionZone_body_exited(_body):
	PlayerBody = null
