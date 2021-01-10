extends ProgressBar




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Spinner_speed(value):
	set_value(value*get_max())
