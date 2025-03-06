extends AnimatedSprite

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	play("Animate")

func _on_animation_finished(): #gets called whenever animation_finished is signaled
	queue_free()

