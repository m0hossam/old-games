extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 500
var collision

func _physics_process(_delta):
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed
	elif Input.is_action_pressed("ui_down"):
		velocity.y = speed
	else:
		velocity.y = 0
	collision = move_and_slide(velocity)

