extends KinematicBody2D

export var radius = 100
export var speed = 3
const CENTER = Vector2(660, 340)

var time = 0.0

func _ready():
	position.x = CENTER.x
	position.y = CENTER.y - radius
	
func _physics_process(delta):
	time += delta
	var angle = time * speed
	var rotation = Vector2(cos(angle), sin(angle))
	position = CENTER + rotation * radius
