extends KinematicBody2D

var regular_speed = -100
var velocity = Vector2(regular_speed, 0) #less than player max speed
var squashed_flag = false

func _physics_process(_delta):
	if !squashed_flag:
		var _unused_collision_info = move_and_slide(velocity, Vector2(0,-1))
		if is_on_wall():
			velocity.x *= -1
		for i in range(get_slide_count()):
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("Players"):
				collision.collider.hit_by_enemy()
	
func squash():
	if !squashed_flag:
		squashed_flag = true
		var rectangle = $ColorRect
		var timer = $Timer
		var collision_shape = $CollisionShape2D
		collision_shape.queue_free()
		rectangle.color.a = 0.5
		rectangle.rect_size.y /= 2
		rectangle.rect_position.y /= 2
		velocity = Vector2(0,0)
		timer.start()
	
func _on_Timer_timeout():
	queue_free()
