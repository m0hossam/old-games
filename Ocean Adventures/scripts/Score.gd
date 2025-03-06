extends Label

var score = 0

func increment_score():
	score += 10
	text = "%s" % score
