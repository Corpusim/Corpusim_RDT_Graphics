extends Control



export(String, "Spongy Bone", "Epithelial Cells") var environment
export(String, "1E3x", "1E5x") var shrink_level


onready var label_time = $HBoxContainer/timestamp

onready var elapsed_sec:float = 0.0

onready var date_time := OS.get_datetime()
var date
var time

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/label_environment.text = environment
	$VBoxContainer/label_shrink.text = "Shrink " + shrink_level
	



func _process(delta):
	elapsed_sec += delta
	if elapsed_sec > 1:
		date_time = OS.get_datetime()
		date = "%04d" % date_time["year"] + "-" + "%02d" % date_time["month"] \
		+ "-" + "%02d" %  date_time["day"]
		time = "%02d" % date_time["hour"] + ":" \
		+ "%02d" % date_time["minute"] + ":" \
		+ "%02d" % date_time["second"]
		label_time.text = date + "   " + time
		elapsed_sec = 0
	
