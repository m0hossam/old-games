extends Node

export(int) var max_health = 1 setget set_max_health #to make unique max_health for every enemy
var health = max_health setget set_health

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value): #to change max health of player if needed eg. power-up that increases max health
	max_health = value
	self.health = min(health, max_health) #to ensure health can never be larger than max health
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health) #whenever health changes, we emit a signal
	if health <= 0:
		emit_signal("no_health")

func _ready():
	self.health = max_health
