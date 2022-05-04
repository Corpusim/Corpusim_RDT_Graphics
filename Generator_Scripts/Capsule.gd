extends VoxelGeneratorScript

const channel : int = VoxelBuffer.CHANNEL_SDF

var a : Vector3 = Vector3(-6,-4,-8)
var b : Vector3 = Vector3(2,6,-12)
var r : float = 3
	

# from https://iquilezles.org/articles/distfunctions/
func sdCapsule(var p:Vector3, var a:Vector3, var b:Vector3, var r: float) -> float:
	var pa:Vector3 = p - a
	var ba:Vector3 = b - a
	var h:float = clamp(pa.dot(ba) / ba.dot(ba), 0.0,1.0)
	return (pa - ba * h).length() - r
	
func _get_used_channels_mask() -> int:
	return 1 << channel
	
func _generate_block(buffer : VoxelBuffer, origin : Vector3, lod : int) -> void:
	if lod != 0:
		return
	
	# 
	if origin.x > -20 && origin.x < 1 && origin.y < 20 && origin.y > -20 && origin.z < 0 && origin.z > -20:
		for i in range(16):
			for j in range(16):
				for k in range(16):
					buffer.set_voxel_f( sdCapsule(origin+Vector3(i,j,k), a,b,r), i, j, k, channel )

	
