extends Line2D

var length = 100

var point = Vector2.ZERO

func _process(_delta):
	global_position = Vector2.ZERO
	global_rotation = 0 
	var pos = get_parent().global_position
	if point != pos and get_point_count() <= length:
		point = pos
		add_point(point)
	elif get_point_count() > length:
		remove_point(0)

	

