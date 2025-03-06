extends Node

var this_level = load("res://Levels/World1-1.tscn")

func _ready():
	get_node("CanvasLayer/GUI/World/Value").text = "1-1"

func get_this_level():
	return this_level
	
func get_level_data():
	return [$CanvasLayer/GUI/Score.score, $CanvasLayer/GUI/Lives.lives]
	
func set_level_data(data):
	$CanvasLayer/GUI/Score.prev_score(data[0])
	$CanvasLayer/GUI/Lives.prev_lives(data[1])
	$Player.prev_lives(data[1])
