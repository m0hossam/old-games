extends ProgressBar

var total_money
var money = 0

func _ready():
	total_money = get_parent().find_node("WantedMoney").text.to_int()

func change_progress(val):
	if (money+val <= total_money):
		money += val
		value = float(money)/float(total_money)*100
		$Correct.play()
		get_tree().call_group("CurrentMoney", "change_val", money)
	else:
		$Wrong.play()
