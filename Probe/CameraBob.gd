extends Camera

var elapsed := 0.0
var bobbing := false

var timer : Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.2
	timer.connect("timeout", self, "_reactivate_bobbing")
	timer.autostart = true
	
func _physics_process(delta):
	if bobbing:
		elapsed += delta
		#transform.origin.x = 0.3*sin(elapsed*.5) + .2*sin(elapsed*.3)
		transform.origin.y = 0.05*sin(elapsed)
		rotate_y(.0002*sin(elapsed)+.0001*sin(elapsed*2.0))
		rotate_x(.0002*cos(elapsed))
		
func adjust_zoom(adjust_amount):
	if fov < 70 and adjust_amount > 0:
		fov += adjust_amount
		transform.origin.z -= adjust_amount*.2
	elif fov > 10 and adjust_amount < 0:
		fov += adjust_amount
		transform.origin.z -= adjust_amount*.2
		

func deactivate_bobbing():
	bobbing = false
	timer.start()
	
	
func _reactivate_bobbing():
	timer.stop()
	bobbing = true
