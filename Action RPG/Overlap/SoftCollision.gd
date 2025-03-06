extends Area2D

#this function gets the size of the overlapping area if there is any
func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0 

func get_push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	#this statement checks if there is an overlapping area
	if is_colliding():
		var area = areas[0] #gets one of the colliding areas
		push_vector = area.global_position.direction_to(global_position) #creates a vector which pushes in direction of (from area's position to our position)
		push_vector = push_vector.normalized()
	return push_vector
