extends KinematicBody2D

var can_shoot = true
onready var torpedo = preload("res://scenes/Torpedo.tscn")
var velocity = Vector2.ZERO
var collision

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -256
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 256
	else:
		velocity.y = 0
		
	collision = move_and_collide(velocity * delta)
	
	if Input.is_action_just_pressed("ui_shoot") and can_shoot:
		can_shoot = false
		$Timer.start()
		var myTorpedo = torpedo.instance()
		get_parent().add_child(myTorpedo)
		myTorpedo.global_position = $ShootPoint.global_position
		myTorpedo.scoreboard = get_parent().get_node("GUI/Score")
		
	if collision and collision.collider.name != "Boundaries":
		collision.collider.queue_free()
		get_parent().get_node("GUI/Restart").visible = true
		queue_free()

func _on_Timer_timeout():
	can_shoot = true
