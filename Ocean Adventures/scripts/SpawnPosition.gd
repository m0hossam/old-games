extends Position2D

onready var enemy = preload("res://scenes/Enemy.tscn")
onready var texture1 = preload("res://media/BrownFish.png")
onready var texture2 = preload("res://media/OrangeFish.png")
onready var texture3 = preload("res://media/RedFish.png")
onready var texture4 = preload("res://media/PurpleFish.png")

func _on_Timer_timeout():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var random_position = random.randi_range(75, 450)
	var random_texture =  random.randi_range(1, 4)
	global_position.y = random_position
	
	var instance = enemy.instance()
	get_parent().add_child(instance)
	instance.global_position = self.global_position
	
	if random_texture == 1:
		instance.find_node("Sprite").texture = texture1
	elif random_texture == 2:
		instance.find_node("Sprite").texture = texture2
	elif random_texture == 3:
		instance.find_node("Sprite").texture = texture3
	else:
		instance.find_node("Sprite").texture = texture4


func _on_Timer2_timeout():
	$Timer.wait_time -= 0.1
