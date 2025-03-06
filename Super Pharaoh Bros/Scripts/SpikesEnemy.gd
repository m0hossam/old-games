extends KinematicBody2D

var regular_speed = -100
var velocity = Vector2(regular_speed, 0) #less than player max speed
var gravity = 9
var squashed_flag = false

func _physics_process(_delta):
	if !squashed_flag:
		if !is_on_floor():
			velocity.y += gravity
		var _unused_collision_info = move_and_slide(velocity, Vector2(0,-1))
		if is_on_wall():
			velocity.x *= -1
		for i in range(get_slide_count()):
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("Players"):
				collision.collider.hit_by_enemy()
	
func squash():
	get_tree().call_group("Players", "hit_by_enemy")
	
func _on_Timer_timeout():
	queue_free()
