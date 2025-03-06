extends Control

var cooldown = false #cooldown between pausing and resuming

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and self.visible == true and cooldown == true:
			get_tree().paused = false
			self.visible = false
			cooldown = false

func _on_Restart_pressed():
	get_tree().paused = false
	if get_parent().name == "World":
		var _unused = get_tree().change_scene("res://World.tscn")
	elif get_parent().name == "WorldEasyBot":
		var _unused = get_tree().change_scene("res://WorldEasyBot.tscn")
	elif get_parent().name == "WorldMediumBot":
		var _unused = get_tree().change_scene("res://WorldMediumBot.tscn")
	elif get_parent().name == "WorldHardBot":
		var _unused = get_tree().change_scene("res://WorldHardBot.tscn")

func _on_Menu_pressed():
	get_tree().paused = false
	var _unused2 = get_tree().change_scene("res://Start Menu.tscn")

func _on_World_pause_game():
	$Timer.start()

func _on_Timer_timeout():
	cooldown = true
