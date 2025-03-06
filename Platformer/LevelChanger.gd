extends Area2D

export(String, FILE, "*.tscn") var level

func _on_LevelChanger_body_entered(body):
	if body.name == "Player":
		var _unused = get_tree().change_scene(level)
