extends Label

var score
var hi_score

func _ready():
	score = 0
	hi_score = GlobalVars.high_score
	text = "High Score: " + str(hi_score)

func update_score():
	score += 1
	hi_score = max(hi_score, score)
	text = "High Score: " + str(hi_score)

func get_high_score():
	return hi_score
