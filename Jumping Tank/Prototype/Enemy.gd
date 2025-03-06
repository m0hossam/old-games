extends KinematicBody2D

var health = 100
var hit = 10
var can_shoot = true
var bullet_scn = preload("res://Prototype/Bullet.tscn")
var hlth = preload("res://Prototype/HealthPowerup.tscn")
var ammo = preload("res://Prototype/AmmoPowerup.tscn")
var found_player = false
var rotation_speed = 2
var speed = 100
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var player_body = null #to keep track of player pos
var wandering = false
var wander_dir = Vector2.ZERO

onready var aimer = $Aimer

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$WanderStart.wait_time = rng.randi_range(1, 5)
	$WanderStart.start()

func _physics_process(_delta):
	if found_player:
		move_towards_player()
	if wandering:
		wander()

func move_towards_player():
	#aimer_vect: st.line from aimer to player
	#center_vect: st.line from enemy to player
	#angle between two vects should be minimzed to <= 1
	var aimer_vect = player_body.global_position - aimer.global_position
	var center_vect = player_body.global_position - global_position
	var angle = rad2deg(aimer_vect.angle_to(center_vect))
	
	if abs(angle) <= 1 and aimer_vect.length() < center_vect.length():
		#second condition: to avoid enemy facing same direction as player while player is behind him
		#shoot:
		if can_shoot:
			$TankShot.play()
			can_shoot = false
			$Timer.start()
			var bullet = bullet_scn.instance()
			get_parent().add_child(bullet)
			bullet.position = aimer.global_position
			bullet.update_direction(global_position.direction_to(aimer.global_position), false)
		#move:
		if center_vect.length() > 90:
			direction = aimer_vect.normalized()
		else:
			direction = Vector2.ZERO
	elif angle > 0: #rotate anti-clockwise
		direction = Vector2.ZERO
		rotation_degrees -= rotation_speed
	else: #rotate clockwise
		direction = Vector2.ZERO
		rotation_degrees += rotation_speed
	
	velocity = move_and_slide(direction * speed)

func wander():
	if found_player:
		wandering = false
	else:
		var tank_dir = (aimer.global_position - global_position).normalized()
		var angle = rad2deg(tank_dir.angle_to(wander_dir))
		
		if abs(angle) <= 1 and tank_dir.x*wander_dir.x >= 0 and tank_dir.y*wander_dir.y >= 0:
			velocity = move_and_slide(wander_dir * speed)
		elif angle > 0:
			rotation_degrees += rotation_speed
		else:
			rotation_degrees -= rotation_speed

func damage():
	if health != 0:
		health = max(health-hit, 0)
		$ProgressBar.value = health
	if health == 0:
		var powerup1 = hlth.instance()
		get_parent().add_child(powerup1)
		powerup1.global_position = global_position
		var powerup2 = ammo.instance()
		get_parent().add_child(powerup2)
		powerup2.global_position.x = global_position.x + 20
		powerup2.global_position.y = global_position.y + 20
		queue_free()

func _on_PlayerZone_body_entered(body):
	if body.name == "Player":
		found_player = true
		player_body = body

func _on_PlayerZone_body_exited(body):
	if body.name == "Player":
		found_player = false
		velocity = Vector2.ZERO
		player_body = null

func _on_Timer_timeout():
	can_shoot = true

func _on_WanderTimer_timeout():
	if !found_player:
		wandering = true
		$WanderDuration.start()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		wander_dir.x = rng.randf_range(-1.0, 1.0)
		wander_dir.y = rng.randf_range(-1.0, 1.0)
		wander_dir = wander_dir.normalized()

func _on_WanderDuration_timeout():
	wandering = false
	velocity = Vector2.ZERO

func _on_WanderStart_timeout():
	$WanderTimer.start()
