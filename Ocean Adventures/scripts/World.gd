extends Node

func _process(_delta):
	if Input.is_action_just_pressed("ui_restart"):
		var _x = get_tree().reload_current_scene()
	if Input.is_action_just_pressed("ui_exit"):
		get_tree().quit()
