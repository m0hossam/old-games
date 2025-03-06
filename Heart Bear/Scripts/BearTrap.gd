extends Area2D


var current_body
var is_deadly = false

func _physics_process(_delta):
	if current_body != null and is_deadly:
		is_deadly = false
		get_tree().call_group("World", "decrease_lives")


func _ready():
	var rng = RandomNumberGenerator.new()
	var time = rng.randi_range(2, 5)
	$TrapTimer.wait_time = time
	$TrapTimer.start()


func _on_trap_timer_timeout():
	$AnimatedSprite2D.play()
	$TrapCooldown.start()
	$TrapStart.start()


func _on_trap_start_timeout():
	is_deadly = true


func _on_trap_cooldown_timeout():
	$AnimatedSprite2D.pause()
	is_deadly = false
	$AnimatedSprite2D.frame = 0
	$TrapTimer.start()


func _on_body_entered(body):
	if body.name == "Player":
		current_body = body


func _on_body_exited(body):
	if body.name == "Player":
		current_body = null

