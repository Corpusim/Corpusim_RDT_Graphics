extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _process(delta):
	process_input()
	
func process_input():
	
	if Input.is_action_just_pressed("toggle_ui"):
		if visible == true:
			visible = false
		else:
			visible = true
	
