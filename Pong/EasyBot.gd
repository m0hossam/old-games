extends KinematicBody2D

onready var ball = get_parent().get_node("Ball2")

var easy_error = 50
var velocity = Vector2.ZERO
var easy_speed = 500
var collision

func _physics_process(_delta):
	collision = move_and_slide(Vector2(0, player_dir()) * easy_speed)
	
func player_dir():
	if ball.velocity.x > 0:
		return 0
	if abs(ball.position.y - position.y) > easy_error:
		if (ball.position.y < position.y):
			return -1
		else:
			return 1
	else:
		return 0
	
