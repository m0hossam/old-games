extends Node

func _on_Easy_pressed():
	var _unused = get_tree().change_scene("res://WorldEasyBot.tscn")

func _on_Medium_pressed():
	var _unused = get_tree().change_scene("res://WorldMediumBot.tscn")

func _on_Hard_pressed():
	var _unused = get_tree().change_scene("res://WorldHardBot.tscn")
