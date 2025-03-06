extends Label

export var lives = 3

func update_lives():
	lives -= 1
	$Value.text = str(lives)

func prev_lives(prev):
	lives = prev
	$Value.text = str(lives)
