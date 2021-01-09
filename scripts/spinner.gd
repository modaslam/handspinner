extends Node2D


var velocity = 0
var deceleration = -2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity > 1:
		velocity += deceleration * delta
	else: 
		velocity = 0
		
	get_node("Corp").rotation += delta*velocity


func _on_ContactArea_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		velocity += 5
		if velocity > 50:
			velocity = 50
