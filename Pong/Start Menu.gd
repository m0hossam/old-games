extends Node

func _on_PvP_pressed():
	var _unused = get_tree().change_scene("res://World.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _on_PvC_pressed():
	var _unused = get_tree().change_scene("res://Computer Menu.tscn")
