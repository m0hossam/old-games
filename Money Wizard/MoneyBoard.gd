extends ColorRect

func _ready():
	pass # Replace with function body.
	
func can_drop_data(_position, data):
	return typeof(data) == typeof(ColorRect)
	
func drop_data(_position, data):
	get_tree().call_group("Progress", "change_progress", data.value)



