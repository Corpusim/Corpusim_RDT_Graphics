extends Spatial

const gen_cubes_asset = preload("tut_cubes.gd")
const gen_capsule_asset = preload("Capsule.gd")
const gen_lace_asset = preload("../Generator_Graphs/Lace.tres")

var gen_cubes
var gen_capsule
var gen_lace

var env_timer:Timer = Timer.new()

# Get the terrain
onready var terrain = get_node("../Corpus/VoxelVolume")

func _ready():
	gen_cubes = gen_cubes_asset.new()
	gen_capsule = gen_capsule_asset.new()
	
	terrain.generator = gen_lace_asset
	
	
	add_child(env_timer)
	env_timer.connect("timeout", self, "switch_env")
	env_timer.one_shot = false
	env_timer.start(8)
	
	
func switch_env():
	return
	print("switching env")
	if terrain.generator == gen_capsule:
		terrain.generator = gen_lace_asset
	else:
		terrain.generator = gen_capsule

	
	
