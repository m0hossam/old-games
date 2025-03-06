extends KinematicBody2D

onready var paddle_sound = get_parent().get_node("PaddleHit")
onready var wall_sound = get_parent().get_node("WallHit")

var speed = 800
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()

func _ready():
	initial_velocity()
	
func _physics_process(delta):
	var collision_object = move_and_collide(velocity * speed * delta)
	if collision_object:
		velocity = velocity.bounce(collision_object.normal)
		if "Player" in collision_object.collider.name or "Bot" in collision_object.collider.name:
			paddle_sound.play()
			if collision_object.collider_velocity.y*velocity.y < 0:
				velocity.y = -velocity.y
			if velocity.y > 0.5:
				velocity.y =  0.5
				velocity.x = sqrt(1 - pow(0.5, 2))
			elif velocity.y < -0.5:
				velocity.y =  -0.5
				velocity.x = sqrt(1 - pow(-0.5, 2))
		else:
			wall_sound.play()

func initial_velocity(): #respawn ball when it's out of bounds
	rng.randomize() #generate random seed
	velocity.y = rng.randf_range(-0.5, 0.5) #to avoid vertical trajectories
	velocity.x = sqrt(1 - pow(velocity.y, 2))
	if velocity.y < 0:
		velocity.x = -velocity.x
	
func _on_World_ball_out_of_bounds():
	$Timer.start() #cooldown before respawn

func _on_Timer_timeout(): #respawn the ball
	self.global_position = Vector2(520, 245)
	self.initial_velocity()
