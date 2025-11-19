extends Skeleton_Warrior

@export var player_detection_radius := 25

func _ready() -> void:
	attack_radius = 1.5
	health = 2
	player = null
	$DetectionArea/CollisionShape3D.shape.radius = player_detection_radius

func _physics_process(delta: float) -> void:
	if player != null:
		move_to_player(player)

func _on_detection_area_body_entered(body: Node3D) -> void:
	if body.is_in_group('Player'):
		player = body


func _on_detection_area_body_exited(body: Node3D) -> void:
	if body.is_in_group('Player'):
		player = null
