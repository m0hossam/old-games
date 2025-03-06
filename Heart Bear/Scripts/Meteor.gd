extends RigidBody2D

@export var speed = 350
@export var angle = 0

func _ready():
	rotation_degrees -= angle # set body's rotation to 90
	z_index = RenderingServer.CANVAS_ITEM_Z_MAX #on top of screen
	linear_velocity.x = speed * cos(deg_to_rad(angle))
	linear_velocity.y = -speed * sin(deg_to_rad(angle))

func _physics_process(_delta):
	#contanct_monitor = on, max_contacts_reported >= 2
	var list = get_colliding_bodies()
	for node in list:
		if node.is_in_group("Player"):
			get_tree().call_group("World", "kill_player")
			break
