extends Node

var level1 = preload("res://Prototype/World.tscn")

func _on_Button_pressed():
	var _unused = get_tree().change_scene_to(level1)
