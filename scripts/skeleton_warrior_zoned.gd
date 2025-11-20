extends Skeleton_Warrior

@export var player_detection_radius := 25

func _ready() -> void:
	attack_radius = 1.5
	health = 2
	player = null
	$DetectionArea/CollisionShape3D.shape.radius = player_detection_radius

func _physics_process(delta: float) -> void:
	if player != null:
		move_to_player(delta,player)
	else:
		velocity = Vector3.ZERO
		move_state_machine.travel('Idle')

func _on_detection_area_body_entered(body: Node3D) -> void:
	if body.is_in_group('Player'):
		player = body

func _on_attack_timer_timeout() -> void:
	if player != null:
		$Timers/AttackTimer.wait_time = rng.randf_range(1.5,2.5)
		if position.distance_to(player.position) < attack_radius:
			#attack_animation.animation = attack_names.pick_random()
			#print(attack_animation.animation)
			$AnimationTree.set("parameters/AttackOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func _on_detection_area_body_exited(body: Node3D) -> void:
	if body.is_in_group('Player'):
		player = null
 
