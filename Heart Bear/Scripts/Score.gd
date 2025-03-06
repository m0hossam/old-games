extends Label

var score = 0

func update_score():
	if score == 0:
		get_tree().call_group("World", "start_meteor_timer")
	score += 1
	text = str(score) + "x"
