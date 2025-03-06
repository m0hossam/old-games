extends Area2D


func _ready():
	$CPUParticles2D.emitting = true


func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.name == "Player":
		get_tree().call_group("Score", "update_score")
		queue_free()
