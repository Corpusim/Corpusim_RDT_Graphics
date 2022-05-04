extends VoxelGeneratorScript

const channel : int = VoxelBuffer.CHANNEL_SDF

func _get_used_channels_mask() -> int:
	return 1 << channel

func _generate_block(buffer : VoxelBuffer, origin : Vector3, lod : int) -> void:
	if lod != 0:
		return
	if origin.y < 0:
		buffer.fill(1, channel)
	if origin.x == origin.z and origin.y < 1:
		buffer.fill_area(1, Vector3(0,0,0),Vector3(16,8,16),channel)
		buffer.fill_area(1, Vector3(0,8,0),Vector3(8,16,16),channel)
		
