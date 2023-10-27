extends MeshInstance3D

var phi = (1.0 + sqrt(5.0)) / 2.0  # The Golden Ratio
	# Define the 20 vertices of the dodecahedron
var vertices = [
  Vector3(1.0, 1.0, 1.0),
  Vector3(-1.0, 1.0, 1.0),
  Vector3(-1.0, -1.0, 1.0),
  Vector3(1.0, -1.0, 1.0),
  Vector3(1.0, 1.0, -1.0),
  Vector3(-1.0, 1.0, -1.0),
  Vector3(-1.0, -1.0, -1.0),
  Vector3(1.0, -1.0, -1.0),
  Vector3(0.0, 1.61803398875, 0.61803398875),
  Vector3(0.0, -1.61803398875, 0.61803398875),
  Vector3(0.0, 1.61803398875, -0.61803398875),
  Vector3(0.0, -1.61803398875, -0.61803398875),
  Vector3(0.61803398875, 0.61803398875, 1.61803398875),
  Vector3(-0.61803398875, 0.61803398875, 1.61803398875),
  Vector3(0.61803398875, -0.61803398875, 1.61803398875),
  Vector3(-0.61803398875, -0.61803398875, 1.61803398875),
  Vector3(1.61803398875, 0.61803398875, 0.61803398875),
  Vector3(-1.61803398875, 0.61803398875, 0.61803398875),
  Vector3(1.61803398875, -0.61803398875, 0.61803398875),
  Vector3(-1.61803398875, -0.61803398875, 0.61803398875)
]


var indices = [
	Vector2(0, 1), Vector2(1, 2), Vector2(2, 3), Vector2(3, 4), Vector2(4, 0)
]



func _ready():
	for ind in indices:
		line(vertices[ind.x],vertices[ind.y],Color.RED)

	for v in vertices:
		point(v,.05,Color.BLACK)
func getClosest(nogo,vert):
	var closest
	for v in  vertices:
		if not v in nogo:
			if not closest or v.distance_to(vert) <  closest.distance_to(vert):
				closest = v
	return closest

func line(pos1: Vector3, pos2: Vector3, color = Color.WHITE_SMOKE, persist_ms = 0):
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(pos1)
	immediate_mesh.surface_add_vertex(pos2)
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	add_child.call_deferred(mesh_instance)
	if persist_ms:
		await get_tree().create_timer(persist_ms).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance


func point(pos:Vector3, radius = 0.05, color = Color.WHITE_SMOKE, persist_ms = 0):
	var mesh_instance := MeshInstance3D.new()
	var sphere_mesh := SphereMesh.new()
	var material := ORMMaterial3D.new()
		
	mesh_instance.mesh = sphere_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	mesh_instance.position = pos
	
	sphere_mesh.radius = radius
	sphere_mesh.height = radius*2
	sphere_mesh.material = material
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	add_child.call_deferred(mesh_instance)
	if persist_ms:
		await get_tree().create_timer(persist_ms).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance
