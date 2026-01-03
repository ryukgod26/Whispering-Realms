class_name Enemy
extends CharacterBody3D

@onready var player = get_tree().get_first_node_in_group('Player')
@onready var skin = get_node('skin')
@onready var move_state_machine = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var attack_animation = $AnimationTree.get_tree_root().get_node('AttackAnimation')

@export var walk_speed := 2.0
@export var speed = walk_speed
@export var detection_radius := 30.0
@export var attack_radius := 3.0

var health_bar:ProgressBar

func _ready() -> void:
	health_bar = $SubViewport/HealthBar  

var rng = RandomNumberGenerator.new()
var speed_modifier := 1.0
var squash_and_stretch := 1.0:
	set(value):
		squash_and_stretch = value
		var negative = 1.0 + (1.0 - value)
		scale = Vector3(negative,squash_and_stretch,negative)
var health = 5:
	set(value):
		health = value
		if health <= 0:
			die()
		if health_bar:
			health_bar._set_health(value)
			print("Updated Health Bar")
		else:
			print("Does Not Updated Health")


func move_to_player(delta) -> void:
	if position.distance_to(player.position) < detection_radius:
		var target_dir = (player.position - position).normalized()
		var dir_vec2 = Vector2(target_dir.x,target_dir.z)
		var target_angle = -dir_vec2.angle() + PI/2
		rotation.y = rotate_toward(rotation.y,target_angle,delta * 6)
		if position.distance_to(player.position) > attack_radius:
			velocity = Vector3(dir_vec2.x,0,dir_vec2.y)  * speed * speed_modifier
			move_state_machine.travel('Walk')
		else:
			velocity = Vector3.ZERO
			move_state_machine.travel('Idle')
		
		if not is_on_floor():
			velocity.y -= 2
		else:
			velocity.y = 0
		move_and_slide()

func stop_movement(start_duration: float,end_duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(self,"speed_modifier",0.0,start_duration)
	tween.tween_property(self,"speed_modifier",1.0,end_duration)

func hit() -> void:
	if not $Timers/InvulTimer.time_left:
		do_squash_and_strecth(1.2,0.15)
		$Timers/InvulTimer.start()
		health -= 1
		print(health)

func do_squash_and_strecth(value: float,duration: float = 0.1) -> void:
	var tween = create_tween()
	tween.tween_property(self,"squash_and_stretch",value,duration)
	tween.tween_property(self,"squash_and_stretch",1.0,duration * 1.8).set_ease(Tween.EASE_OUT)

func die() -> void:
	queue_free()
