extends ParallaxBackground

export var scroll_speed = -15

func _physics_process(delta):
	$ParallaxLayer.motion_offset.x += scroll_speed * delta
	$ParallaxLayer2.motion_offset.x += (scroll_speed - 10) * delta
	$ParallaxLayer3.motion_offset.x += (scroll_speed - 20) * delta
	$ParallaxLayer4.motion_offset.x += (scroll_speed - 30) * delta
