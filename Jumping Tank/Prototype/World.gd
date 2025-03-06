extends Node

var lava_attacks = 0

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		var _unused = get_tree().change_scene("res://Prototype/Main Menu.tscn")
	$WorldTemp/GUI/Label.text = "Ground Will Turn To Lava In: " + str(int($LavaTimer.time_left))

func lava():
	get_tree().call_group("Enemies", "damage")
	if get_node_or_null("Player") != null:
		if !$Player.get_flying():
			get_tree().call_group("Players", "damage")

func _on_LavaTimer_timeout():
	$WorldTemp/Ground.texture = load("res://LavaGround.png")
	lava()
	$LavaCooldown.start()

func _on_LavaCooldown_timeout():
	lava()
	lava_attacks += 1
	if lava_attacks == 3:
		$LavaCooldown.stop()
		lava_attacks = 0
		$LavaTimer.start()
		$WorldTemp/Ground.texture = load("res://SandyGround.png")
