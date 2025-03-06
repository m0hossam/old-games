extends Label

export var score = 0

func update_score():
	score += 100
	$Value.text = str(score)

func prev_score(prev):
	score = prev
	$Value.text = str(score)
