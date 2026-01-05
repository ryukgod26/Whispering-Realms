extends  Enemy

const normal_attack = {
	'chop' : '1H_Melee_Attack_Chop',
	'slice' : '1H_Melee_Attack_Slice_Diagonal',
	'slice2' : '2H_Melee_Attack_Slice',
	'spin' : '2H_Melee_Attack_Spin',
	'range' : '1H_Melee_Attack_Stab'
}
const normal_attack_names = ['1H_Melee_Attack_Chop','1H_Melee_Attack_Slice_Diagonal','2H_Melee_Attack_Slice','2H_Melee_Attack_Spin']

var spin_speed := 6.0
var spinning := false
var can_damage := false

signal cast_spell

func _ready() -> void:
	attack_radius = 6.0
	health = 20
	health_bar = $SubViewport/HealthBar
	health_bar._init_health(health)

func _process(_delta: float) -> void:
	attack_logic()

func _physics_process(delta: float) -> void:
	move_to_player(delta)

func _on_attack_timer_timeout() -> void:
	$Timers/AttackTimer.wait_time = randf_range(4.0,5.5)
	if position.distance_to(player.position) < 3.0:
		melee_attack_animation()
	#elif  position.distance_to(player.position) < 6.0 and position.distance_to(player.position) > 5.0:
		#range_attack_animation()
	else:
		if rng.randi() %2 :
			range_attack_animation()
		else:
			spin_attack_animation()

func melee_attack_animation() -> void:
	attack_animation.animation = normal_attack_names.pick_random()
	$AnimationTree.set("parameters/AttackOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func range_attack_animation() -> void :
	#stop_movement(1.5,1.5)
	attack_animation.animation = '1H_Melee_Attack_Stab'
	$AnimationTree.set("parameters/AttackOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func spin_attack_animation() -> void:
	var tween = create_tween()
	tween.tween_property(self,"speed",spin_speed,0.1)
	tween.tween_method(_spin_change,0.0,1.0,0.3)

func _spin_change(val) ->void:
	$AnimationTree.set("parameters/SpinBlend/blend_amount",val)
	$Timers/AttackTimer.stop()
	spinning = true
	can_damage = true

func _on_spin_area_body_entered(_body: Node3D) -> void:
	if spinning:
		await  get_tree().create_timer(rng.randf_range(1.0,2.9)).timeout
		var tween = create_tween()
		tween.tween_property(self,"speed",walk_speed,0.4)
		tween.tween_method(_spin_change,1.0,0.0,0.3)
		spinning = false
		can_damage = false
		$Timers/AttackTimer.start()

func hit() -> void:
	if not $Timers/InvulTimer.time_left:
		#do_squash_and_strecth(1.2,0.15)
		#print("Boss is getting Hit.")
		$Timers/InvulTimer.start()
		health -= 1
		var tween = create_tween()
		tween.tween_method(_hit_effect,0.0,08,0.3)
		tween.tween_method(_hit_effect,0.8,0.0,0.1)

func damage_toggle(val:bool):
	can_damage = val

func attack_logic() -> void:
	#print("Can Damage:",can_damage)
	if can_damage:
		var collider = $skin/Rig/Skeleton3D/handslot_r/Nagonford_Axe/RayCast3D.get_collider()
		#print(collider)
		if collider and collider.has_method('hit'):
			collider.hit()

func shoot_fireball() -> void:
	var dir = (player.position - position).normalized()
	emit_signal("cast_spell","fireball",$skin/Rig/Skeleton3D/handslot_r/Nagonford_Axe/Marker3D.global_position,Vector2(dir.x,dir.z),3.)

func _hit_effect(val: float):
	$skin/Rig/Skeleton3D/Nagonford_Body.material_overlay.set_shader_parameter('color',Color.RED)
	$skin/Rig/Skeleton3D/Nagonford_Body.material_overlay.set_shader_parameter('alpha',val)
