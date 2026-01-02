extends Enemy

signal cast_spell

func _ready() -> void:
	attack_radius = 10
	health = 2

func _physics_process(delta: float) -> void:
	move_to_player(delta)

func _on_attack_timer_timeout() -> void:
	$Timers/AttackTimer.wait_time = rng.randf_range(1.8,2.5)
	if position.distance_to(player.position) < attack_radius:
		$AnimationTree.set("parameters/AttackOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func shoot_fireball() -> void:
	var dir = (player.position - position).normalized()
	print("Shoot Fireball")
	emit_signal("cast_spell","fireball",$skin/Rig/Skeleton3D/RightHandSlot/wand/wand/Marker3D.global_position,Vector2(dir.x,dir.z),1.)

func die() -> void:
	$AnimationTree.set("parameters/DeathOneSHot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
