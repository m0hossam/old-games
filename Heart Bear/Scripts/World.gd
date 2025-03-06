extends Node2D


var spawners = []
var lives = []
var lives_counter = 0
var heart_scene = preload("res://Scenes/heart.tscn")
var last_spawn = -1
var no_of_spawners


func _ready():
	var heart_groups = get_tree().get_nodes_in_group("HeartSpawners")
	
	for group in heart_groups:
		var  nodes = group.get_children()
		for node in nodes:
			spawners.push_back(node.global_position)
	
	no_of_spawners = spawners.size()
	lives = get_tree().get_nodes_in_group("BearLives")


func spawn_heart():
	var rng = RandomNumberGenerator.new()
	var index = rng.randi_range(0, no_of_spawners-1)
	if index == last_spawn:
		if index == 0:
			index = no_of_spawners-1
		else:
			index -= 1
	last_spawn = index
	var pos = spawners[index]
	var heart = heart_scene.instantiate()
	add_child(heart)
	heart.global_position = pos


func _on_heart_spawn_timer_timeout():
	spawn_heart()


func decrease_lives():
	get_tree().call_group("Player", "play_damage_flash")
	if lives_counter == 3: #just in case teleportation causes double damage or smth
		kill_player()
	lives[lives_counter].frame = 1
	lives_counter += 1
	if lives_counter == 3:
		kill_player()


func kill_player():
	GlobalVars.high_score = $GUI/HiScore.get_high_score()
	var world_scene = load("res://Scenes/world.tscn")
	get_tree().change_scene_to_packed(world_scene)


func start_meteor_timer():
	$MeteorShowerTimer.start()


# meteor & seasons art
# sound effects
# particle effects
# main menu
# music 

