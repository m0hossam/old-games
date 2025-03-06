extends ColorRect

var dict = {
	200 : "res://200Banknote.tscn",
	100 : "res://100Banknote.tscn",
	50 : "res://50Banknote.tscn",
	20 : "res://20Banknote.tscn",
	10 : "res://10Banknote.tscn",
	5 : "res://5Banknote.tscn",
	1 : "res://1Banknote.tscn"
}

var value

func _ready():
	value = $Label.text.to_int()

func get_drag_data(_position):
	var scene = load(dict[value])
	var data = scene.instance()
	set_drag_preview(data)
	return data
