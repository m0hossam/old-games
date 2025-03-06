extends Node

signal ball_out_of_bounds
signal pause_game

var score = 0
var score2 = 0
var winning_score = 10

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and $GUI.visible == false:
		emit_signal("pause_game")
		$GUI.visible = true
		get_tree().paused = true
		

func _on_Left_body_entered(_body):
	emit_signal("ball_out_of_bounds")
	score += 1
	$Score.text = str(score)
	if score == winning_score:
		$GUI.visible = true
		get_tree().paused = true

func _on_Right_body_entered(_body):
	emit_signal("ball_out_of_bounds")
	score2 += 1
	$Score2.text = str(score2)
	if score2 == winning_score:
		$GUI.visible = true
		get_tree().paused = true
