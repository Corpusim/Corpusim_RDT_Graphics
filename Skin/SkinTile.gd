extends Spatial
class_name SkinTile

var tile_size = 16
const subd_level = 8

const height_scalar = 60
# Called when the node enters the scene tree for the first time.

var mesh_instance
var noise
var x
var z
var chunk_size
var should_remove = true

# ctor
func _init(noise, x, z, tile_size):
	self.noise = noise
	self.x = x
	self.z = z
	self.tile_size = tile_size


func _ready():
	generate_tile()
	
	
func generate_tile():
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(tile_size, tile_size)
	plane_mesh.subdivide_depth = tile_size * subd_level
	plane_mesh.subdivide_width = tile_size * subd_level
	
	plane_mesh.material = load("res://Chunk/Chunk.material")
	
	var mesh_instance = MeshInstance.new()
	mesh_instance.mesh = plane_mesh
	add_child(mesh_instance)


