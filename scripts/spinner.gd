extends Node2D


var velocity = 0
var deceleration = -2

var block = false

signal speed(value)
signal limit
signal zero

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity > 1:
		velocity += deceleration * delta
	else: 
		velocity = 0
		deceleration = -2
		if block:
			emit_signal("zero")
		
	get_node("Corp").rotation += delta*velocity
	
	emit_signal("speed", velocity/50)


func _on_ContactArea_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed and not block:
		velocity += 5
		if velocity > 50:
			velocity = 50
			emit_signal("limit")


func _on_BtnBlack_pressed():
	get_node("Corp/Sprite").set_texture(load("res://assets/black_ready.png"))


func _on_BtnRed_pressed():
	get_node("Corp/Sprite").set_texture(load("res://assets/red_ready.png"))


func _on_BtnYellow_pressed():
	get_node("Corp/Sprite").set_texture(load("res://assets/yellow_ready.png"))


func _on_Game_block():
	block = true
	deceleration = -10


func _on_Game_unblock():
	block = false
