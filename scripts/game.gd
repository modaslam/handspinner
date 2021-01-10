extends Node2D


var score1 = 0
var score2 = 0

var spinner1_ready = false
var spinner2_ready = false

var resetting
var time

signal block
signal unblock

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_score():
	get_node("Control/Player1/Score").set_text(str(score1))
	get_node("Control/Player2/Score").set_text(str(score2))
	
	emit_signal("block")
	spinner1_ready = false
	spinner2_ready = false


func _on_Spinner1_limit():
	score1 += 1
	get_node("Control/Player1/Msg").set_text("You won!")
	get_node("Control/Player2/Msg").set_text("You lost!")
	set_score()


func _on_Spinner2_limit():
	score2 += 1
	get_node("Control/Player2/Msg").set_text("You won!")
	get_node("Control/Player1/Msg").set_text("You lost!")
	set_score()


func _on_Spinner1_zero():
	spinner1_ready = true
	if spinner2_ready:
		reset()


func _on_Spinner2_zero():
	spinner2_ready = true
	if spinner1_ready:
		reset()


func reset():
	if resetting: return
	resetting = true
	get_node("Control/Player1/Msg").set_text("")
	get_node("Control/Player2/Msg").set_text("")
	time = 5
	get_node("BetweenRound").start()


func _on_BetweenRound_timeout():
	time -= 1
	if time > 1:
		get_node("Control/Player1/Msg").set_text(str(time-1))
		get_node("Control/Player2/Msg").set_text(str(time-1))
	if time == 1:
		get_node("Control/Player1/Msg").set_text("GO!")
		get_node("Control/Player2/Msg").set_text("GO!")
		resetting = false
		emit_signal("unblock")
	if time == 0: 
		get_node("Control/Player1/Msg").set_text("")
		get_node("Control/Player2/Msg").set_text("")
