extends Control



export(String, "Spongy Bone", "Epithelial Cells") var environment



onready var label_time = $HBoxContainer/timestamp
onready var label_shrink = $VBoxContainer/label_shrink

onready var elapsed_sec:float = 0.0

onready var date_time := OS.get_datetime()
var date
var time

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/label_environment.text = environment
	get_node("../PlayerProbe").connect("shrink_level_adjusted",self,"_on_shrink_adjusted")
	
	_on_shrink_adjusted(5.0)



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
	
func _on_shrink_adjusted(new_val):
	label_shrink.text = "Shrink: 1E" + "%0.2f" % new_val + "x"
