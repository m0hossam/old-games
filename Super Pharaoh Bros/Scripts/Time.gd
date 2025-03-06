extends Label

var time = 420

func _on_Timer_timeout():
	$Value.text = str(time-1)
	time -= 1
	if time == 0:
		$Timer.stop()
		#decrease player's lives
