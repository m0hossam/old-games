extends KinematicBody2D

onready var ball = get_parent().get_node("Ball2")

var hard_error = 25
var velocity = Vector2.ZERO
var hard_speed = 500
var collision

func _physics_process(_delta):
	collision = move_and_slide(Vector2(0, player_dir()) * hard_speed)
	
func player_dir():
	if ball.velocity.x > 0:
		return 0
	if abs(ball.position.y - position.y) > hard_error:
		if (ball.position.y < position.y):
			return -1
		else:
			return 1
	else:
		return 0
	
