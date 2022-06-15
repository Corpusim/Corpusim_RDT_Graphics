extends KinematicBody


export var VR_Mode : bool = false

var MOUSE_SENSITIVITY = 0.015

onready var corpus = $"../Corpus"
onready var camera 
onready var voxel_cutter = $VoxelCutter
onready var rotation_helper = $RotationHelper

var dir

var _editing_voxels = false


var shrink_level := 5.0



var vel = Vector3()
const MAX_SPEED = 6.0
const CUTTER_RATIO = 0.3
const ACCEL = 2.0
const DEACCEL = 2.0

var camera_rotated = false
var origin_moved = false

signal shrink_level_adjusted(adj_amt)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var vr_cam = $ARVROrigin/ARVRCamera
	var desktop_cam = $RotationHelper/Camera
	if VR_Mode:
		$ARVROrigin.enable_vr()
		desktop_cam.clear_current()
		vr_cam.make_current()
		camera = vr_cam
	else:
		$ARVROrigin.disable_vr()
		vr_cam.clear_current()		
		desktop_cam.make_current()
		camera = desktop_cam
		
	
	
		
func _process(delta):
	process_input()
	process_movement(delta)
	
func process_input():
	
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
		
		
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	dir = Vector3()
	var cam_xform = camera.get_global_transform()
	
	
	
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
		
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		voxel_cutter._action_remove = true
		_editing_voxels = true
		
		
	elif Input.is_mouse_button_pressed(BUTTON_LEFT):
		voxel_cutter._action_place = true
		_editing_voxels = true
		
	else:
		_editing_voxels = false
		
	if Input.is_action_just_released("zoom_in"):
		shrink_level += camera.adjust_zoom(-5)
		emit_signal("shrink_level_adjusted", shrink_level)
	elif Input.is_action_just_released("zoom_out"):
		shrink_level += camera.adjust_zoom(5)
		emit_signal("shrink_level_adjusted", shrink_level)
		
		
		
	var input_movement_vector = Vector3()

	if Input.is_action_pressed("movement_forward"):
		input_movement_vector.z -= 1
	if Input.is_action_pressed("movement_backward"):
		input_movement_vector.z += 1
	if Input.is_action_pressed("movement_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_right"):
		input_movement_vector.x += 1
	if Input.is_action_pressed("movement_up"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("movement_down"):
		input_movement_vector.y -= 1
	
	
	input_movement_vector = input_movement_vector.normalized()
	
	if (VR_Mode == false) && (input_movement_vector.length_squared() > 0.05):
		camera.deactivate_bobbing()
	
	dir += cam_xform.basis.x * input_movement_vector.x
	dir += cam_xform.basis.y * input_movement_vector.y
	dir += cam_xform.basis.z * input_movement_vector.z

func process_movement(delta):
	
	dir = dir.normalized()

	var hvel = vel

	var target = dir
	if _editing_voxels:
		target *= MAX_SPEED * CUTTER_RATIO
	else:
		target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.y = hvel.y
	vel.z = hvel.z
	
	if global_transform.origin.y > 20.0 && vel.y > 0:
		vel.y = 0
		
	

	
func _physics_process(delta):
	move_and_slide(vel)
	
func _input(event):
	if (VR_Mode == false) && event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		
		camera.deactivate_bobbing()
		
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		

		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot

	
		
