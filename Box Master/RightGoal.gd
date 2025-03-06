extends Area2D

onready var lscore = get_parent().find_node("UI").find_node("LeftScore")
onready var plr = get_parent().find_node("Player")

func _on_Area2D_body_entered(body):
	if body.name == "Ball":
		var oldscore = int(lscore.text)
		lscore.text = str(1 + oldscore)
		plr.position.x = -256
