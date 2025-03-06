extends KinematicBody2D

export var lives = 3
var bouncing_normals = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1)]
var velocity = Vector2.ZERO
var max_speed = 300
var acceleration = 300
var friction = 600
var gravity = 12
var jump_speed = -450
var dash_multiplier = 1.2 #using dashing requires collectables
var dashing_flag = false
var killed_flag = false

func _ready(): #fixes bug: get bigger powerup then die
	$CollisionShape2D.shape.extents = Vector2(16, 16)

func _physics_process(delta):
	dash()
	move(delta)
	jump()
	squash_enemy()

func move(delta):
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	if direction.x != 0:
		velocity = velocity.move_toward(direction*max_speed, acceleration*delta)
	elif is_on_floor():
		velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
	var _unused = move_and_slide(velocity, Vector2(0, -1))

func jump():
	if !is_on_floor():
		velocity.y += gravity
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		if dashing_flag == true:
			velocity.y = jump_speed*dash_multiplier
		else:
			velocity.y = jump_speed
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.normal in bouncing_normals:
			velocity = velocity.bounce(collision.normal)

func dash(): #needs smoothing and limitation
	if Input.is_action_pressed("Dash") and dashing_flag == false:
		dashing_flag = true
		max_speed *= dash_multiplier
		friction *= dash_multiplier
	elif !Input.is_action_pressed("Dash") and dashing_flag == true:
		dashing_flag = false
		max_speed /= dash_multiplier
		friction /= dash_multiplier

func squash_enemy():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("Enemies"):
			if collision.normal == Vector2(0, -1):
				velocity = velocity.bounce(collision.normal)
				collision.collider.squash()
				if !("Spikes" in collision.collider.name):
					get_tree().call_group("ScoreGUI", "update_score")
			else:
				hit_by_enemy()
		elif collision.collider.is_in_group("PowerUp Blocks"):
			if collision.normal == Vector2(0, 1):
				collision.collider.spawn_powerup()

func hit_by_enemy():
	if !killed_flag:
		killed_flag = true
		$Camera2D.queue_free()
		get_tree().call_group("LivesGUI", "update_lives")
		lives -= 1
		velocity = Vector2.ZERO
		$CollisionShape2D.disabled = true
		$ColorRect.color.a = 0.5
		$Timer.start()

func _on_Timer_timeout():
	if lives == 0:
		var _unused = get_tree().change_scene("res://Levels/Start Menu.tscn")
		get_parent().queue_free()
	else:
		var data = get_parent().get_level_data()
		var lvl = get_parent().get_this_level().instance()
		get_tree().get_root().add_child(lvl)
		lvl.set_level_data(data)
		get_parent().queue_free()

func get_bigger():
	$ColorRect.rect_size = Vector2(48, 48)
	$ColorRect.rect_position = Vector2(-24, -24)
	$CollisionShape2D.shape.extents = Vector2(24, 24)

func prev_lives(prev):
	lives = prev
