extends Label

var coins = 0

func increase_coins():
	coins += 1
	$Value.text = str(coins)

func dec_coins():
	coins -= 1
	$Value.text = str(coins)
