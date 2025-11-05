extends Node3D
@onready var move_state_machine = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var attack_state_machine = $AnimationTree.get("parameters/AttackStateMachine/playback")
@onready var right_hand_slot: BoneAttachment3D = $Rig/Skeleton3D/RightHandSlot
@onready var wand: Node3D = $Rig/Skeleton3D/RightHandSlot/wand2
@onready var sword: Node3D = $Rig/Skeleton3D/RightHandSlot/sword_1handed2

var attacking := false

func set_move_state(state: String)->void:
	move_state_machine.travel(state)

func attack():
	if not attacking:
		attack_state_machine.travel('Slice_Diagonal' if $SecondAttackTimer.time_left else 'Chop')
		$AnimationTree.set("parameters/OneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

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

func cast_spell():
	if not attacking:
		$AnimationTree.set("parameters/SpellCastShoot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
