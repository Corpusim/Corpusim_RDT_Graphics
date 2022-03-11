extends Spatial


#var vt : VoxelTool
var prev_dig_pos : Vector3 = Vector3(0.0,0.0,0.0)
var size : = 8.0

var _action_place = false
var _action_remove = false



#var voxel_volume : VoxelLodTerrain
onready var voxel_volume = get_parent().get_parent().get_node("Corpus/VoxelVolume")
onready var vt : VoxelTool = voxel_volume.get_voxel_tool()

onready var probe : Spatial = get_parent().get_node("RotationHelper")

func _ready():
	pass
	

func _process(_delta):
	pass
	#dig()
	
		
	
		

func _on_Timer_timeout():
	dig()
	#pass
	
		

		
	
		
	

func dig():
	if _action_remove:
		var probe_tf = probe.global_transform
		var pos = probe_tf.origin - 3.0 * probe_tf.basis.z
		voxel_dig(pos,false)
		_action_remove = false
	
	elif _action_place:
		var probe_tf = probe.global_transform
		var pos = probe_tf.origin - 9.0 * probe_tf.basis.z
		voxel_build(pos)
		_action_place = false
	


func voxel_dig(pos,  fill_prev_dig:bool):
	if fill_prev_dig && prev_dig_pos:
		voxel_build(prev_dig_pos)
	#vt.channel = VoxelBuffer.CHANNEL_SDF
	vt.mode = VoxelTool.MODE_REMOVE
	vt.set_sdf_scale(0.1)
	vt.do_sphere(pos, size)
	prev_dig_pos = pos
	#print("cutting ", pos)

func voxel_build(pos):
	#vt.channel = VoxelBuffer.CHANNEL_SDF
	voxel_volume = get_parent().get_parent().get_node("Corpus/VoxelVolume")
	vt = voxel_volume.get_voxel_tool()
	vt.mode = VoxelTool.MODE_ADD
	vt.set_sdf_scale(0.1)
	vt.do_sphere(pos, size)
	#print("building ", pos)



