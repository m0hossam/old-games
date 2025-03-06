extends StaticBody2D

var rng = RandomNumberGenerator.new()
var powerup_spawned = false
var bigger_powerup = load("res://Scenes/BiggerPowerUp.tscn")
var coin = load("res://Scenes/Coin.tscn")

func spawn_powerup():
	if !powerup_spawned:
		powerup_spawned = true
		rng.randomize()
		var chance = rng.randi_range(1, 100)
		if chance <= 65:
			var instance = bigger_powerup.instance()
			get_parent().add_child(instance)
			instance.position.x = position.x
			instance.position.y = position.y - 32 #levitating
		else:
			var instance = coin.instance()
			get_parent().add_child(instance)
			instance.position.x = position.x
			instance.position.y = position.y - 32 #levitating
