extends Spatial

func _ready():
	pass

func enable_vr():
	var VR = ARVRServer.find_interface("OpenVR")
	if VR and VR.initialize():
		get_viewport().arvr = true

		OS.vsync_enabled = false
		Engine.target_fps = 90

func disable_vr():
	var VR = ARVRServer.find_interface("OpenVR")
	if VR and VR.initialize():
		get_viewport().arvr = false
		Engine.target_fps = 60
		OS.vsync_enabled = true
