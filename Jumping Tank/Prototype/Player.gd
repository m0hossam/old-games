extends KinematicBody2D

const MAX_HEALTH = 100
const GROUND_SPEED = 150
const AIR_SPEED = 75
const MAX_BULLETS = 25

var health = MAX_HEALTH
var hit = 10
var bullets = MAX_BULLETS
var enemy_beneath = null
var bullet_scn = preload("res://Prototype/Bullet.tscn")
var can_shoot = true
var rotation_speed = 2
var speed = GROUND_SPEED
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var flying = false

onready var aimer = $Position2D
onready var jump = $AnimationPlayer

func _physics_process(_delta):
	move()
	if Input.is_action_pressed("fly") and !flying and bullets != 0:
		fly()
	if Input.is_action_pressed("shoot") and can_shoot and bullets != 0:
		shoot()
	
func move():
	if Input.is_action_pressed("ui_right"):
		self.rotation_degrees += rotation_speed
	if Input.is_action_pressed("ui_left"):
		self.rotation_degrees -= rotation_speed
	
	if Input.is_action_pressed("ui_up"):
		direction = self.global_position.direction_to($Position2D.global_position)
	elif Input.is_action_pressed("ui_down"):
		direction = aimer.global_position.direction_to(self.global_position)
	else:
		direction = Vector2.ZERO
	
	velocity = move_and_slide(direction * speed)
	
func fly():
	$TankShot.play()
	speed = AIR_SPEED
	flying = true
	collision_layer = 0b10
	collision_mask = 0b10
	$Timer.start()
	bullets -= 1
	$Bullets.text = str(bullets)
	jump.play("Jump")

func shoot():
	$TankShot.play()
	can_shoot = false
	$ShootCooldown.start()
	if flying:
		fly()
		if enemy_beneath: #shoot enemy beneath
			enemy_beneath.damage()
	else:
		bullets -= 1
		$Bullets.text = str(bullets)
		var bullet = bullet_scn.instance()
		get_parent().add_child(bullet)
		bullet.position = aimer.global_position
		bullet.update_direction(global_position.direction_to(aimer.global_position), false)	

func damage():
	if health != 0:
		health = max(health-hit, 0)
		$ProgressBar.value = health
	if health == 0:
		queue_free()

func heal():
	health = min(health+10, MAX_HEALTH)
	$ProgressBar.value = health

func ammo():
	bullets = min(bullets+5, MAX_BULLETS)
	$Bullets.text = str(bullets)

func get_flying():
	return flying

func _on_Timer_timeout(): #flying cooldown timer
	speed = GROUND_SPEED
	flying = false
	collision_layer = 0b1
	collision_mask = 0b1
	$Sprite.frame = 0

func _on_ShootCooldown_timeout():
	can_shoot = true

func _on_EnemyFlyDetection_body_entered(body):
	if "Enemy" in body.name:
		enemy_beneath = body
	
func _on_EnemyFlyDetection_body_exited(body):
	if enemy_beneath:
		if body.name == enemy_beneath.name:
			enemy_beneath = null
