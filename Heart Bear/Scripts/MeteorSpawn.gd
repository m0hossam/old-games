extends Node2D


var meteor_scene = preload("res://Scenes/meteor.tscn")
var no_of_locs
var no_of_meteors = 5


func _ready():
	no_of_locs = get_child_count()


func meteor_shower():
	var locs = []
	var indices = []
	
	for i in range(no_of_meteors):
		var rng = RandomNumberGenerator.new()
		var index = rng.randi_range(0,no_of_locs-1)
		while index in indices:
			index = rng.randi_range(0,no_of_locs-1)
		indices.push_back(index)
		locs.push_back(get_children()[index])
	
	for loc in locs:
		var rng = RandomNumberGenerator.new()
		var deflection = rng.randi_range(30,60) #meteor angle
		
		var meteor = meteor_scene.instantiate()
		get_parent().add_child.call_deferred(meteor)
		
		meteor.global_position = loc.global_position
		meteor.speed = rng.randi_range(350,450) #meteor speed
		
		if "Left" in loc.name:
			meteor.angle = 270 + deflection
		else:
			meteor.angle = 270 - deflection


func _on_meteor_shower_timer_timeout():
	meteor_shower()

