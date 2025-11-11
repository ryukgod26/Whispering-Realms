extends Node3D

@onready var move_state_machine = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var attack_state_machine = $AnimationTree.get("parameters/AttackStateMachine/playback")
@onready var right_hand_slot: BoneAttachment3D = $Rig/Skeleton3D/RightHandSlot
@onready var wand: Node3D = $Rig/Skeleton3D/RightHandSlot/wand2
@onready var sword: Node3D = $Rig/Skeleton3D/RightHandSlot/sword
@onready var extra_animation = $AnimationTree.get_tree_root().get_node("ExtraAnimation")
@onready var face_material: StandardMaterial3D = $Rig/Skeleton3D/Godette_Head.get_surface_override_material(0)

var attacking := false
var squash_and_stretch := 1.0:
	set(value):
		squash_and_stretch = value
		var negative = 1.0 + (1.0 - value)
		scale = Vector3(negative,squash_and_stretch,negative)
var rng = RandomNumberGenerator.new()

const faces ={
	'default': Vector3.ZERO,
	'concentrate': Vector3(0.5,0,0),
	'blink': Vector3(0,0.5,0)}

func set_move_state(state: String)->void:
	move_state_machine.travel(state)

func attack():
	if not attacking:
		attack_state_machine.travel('Slice_Diagonal' if $SecondAttackTimer.time_left else 'Chop')
		$AnimationTree.set("parameters/AttackOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func attack_toggle(value: bool):
	attacking = value

func defend(forward: bool) ->void:
	var tween = create_tween()
	tween.tween_method(_defend_change,1.0 - float(forward), float(forward),0.25)

func _defend_change(val: float) -> void:
	$AnimationTree.set("parameters/ShieldBlend/blend_amount",val)

func switch_weapon(weapon_active: bool):
	if weapon_active:
		sword.show()
		wand.hide()
	else:
		sword.hide()
		wand.show()

func cast_spell() -> void:
	if not attacking:
		extra_animation.animation = "Spellcast_Shoot"
		$AnimationTree.set("parameters/ExtraShoot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func hit() -> void:
	extra_animation.animation = "Hit_B"
	$AnimationTree.set("parameters/ExtraShoot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	$AnimationTree.set("parameters/AttackOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
	attacking = false

func change_face(expression) -> void:
	face_material.uv1_offset = faces[expression]

func _on_blink_timer_timeout() -> void:
	change_face('blink')
	await  get_tree().create_timer(0.2).timeout
	change_face('default')
	$BlinkTimer.wait_time = rng.randf_range(1.2,2.1)

func shoot_magic() -> void:
	get_parent().shoot_magic($Rig/Skeleton3D/RightHandSlot/wand2/wand/Marker3D.global_position)
