extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var material = mesh.surface_get_material(0)
	material.albedo_color = Color.GREEN
	

func _physics_process(delta: float) -> void:
	rotate_y(0.01)
