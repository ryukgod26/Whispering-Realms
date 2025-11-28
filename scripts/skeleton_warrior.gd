class_name Skeleton_Warrior
extends Enemy

const attack_names = ['1H_Melle_Attack_Chop','1H_Melle_Attack_Jump_Chop','1H_Melle_Attack_Slice_Diagonal',
					'1H_Melle_Attack_Slice_Horizontal','1H_Melle_Attack_Stab','2H_Melle_Attack_Chop',
					'2H_Melle_Attack_Slice']
var can_damage = false

func _ready() -> void:
	attack_radius = 1.5
	health = 2

func _physics_process(delta: float) -> void:
	move_to_player(delta)
	print("Normal")

func _on_attack_timer_timeout() -> void:
	$Timers/AttackTimer.wait_time = rng.randf_range(1.5,2.5)
	if position.distance_to(player.position) < attack_radius:
		#attack_animation.animation = attack_names.pick_random()
		#print(attack_animation.animation)
		$AnimationTree.set("parameters/AttackOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func die() -> void:
	print("Tst")
	$AnimationTree.set("parameters/DeathOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func can_damage_toggle(val: bool):
	can_damage = val
