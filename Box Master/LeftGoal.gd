extends Area2D

onready var rscore = get_parent().find_node("UI").find_node("RightScore")
onready var plr2 = get_parent().find_node("Player2")

func _on_Area2D_body_entered(body):
	if body.name == "Ball":
		var oldscore = int(rscore.text)
		rscore.text = str(1 + oldscore)
		plr2.position.x = 576
