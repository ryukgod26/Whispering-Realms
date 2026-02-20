extends CharacterBody3D

@export var defend_speed := 2.0
@export var base_speed := 4.0
@export var run_speed := 6.0
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_fall: float

@onready var godettte_skin: Node3D = $GodettteSkin
@onready var camera = $CameraController/Camera3D
@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak )* -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_fall * jump_time_to_fall)) * -1.0
@onready var ui: Control = $UI
@onready var invul_timer: Timer = $Timers/InvulTimer
@onready var run_particles: GPUParticles3D = $RunParticles
@onready var jump_particles: GPUParticles3D = $JumpParticles

enum spells{FIREBALL,HEAL}

var movement_input:Vector2 = Vector2.ZERO
var run_input:Vector2 = Vector2.ZERO
var target_angle
var defend := false:
	set(value):
		if not defend and value:
			godettte_skin.defend(true)
		if defend and not value:
			godettte_skin.defend(false)
		defend = value
var weapon_active := true:
	set(value):
		weapon_active = value
		if value:
			ui.get_node('Spells').hide()
		else:
			ui.get_node('Spells').show()
var speed_modifier := 1.0
var last_movement_input := Vector2(0,-1)
var health = 5:
	set(value):
		value = min(6,value)
		ui.update_health(value,value-health)
		if value == 0:
			call_deferred('_player_died')
		health = value
var current_spell = spells.FIREBALL
var energy = 100:
	set(value):
		energy = min(100,value)
		ui.update_energy(energy)
var stamina = 100:
	set(value):
		ui.update_stamina(stamina,value)
		if stamina == 100 and value < 100:
			ui.change_stamina_alpha(1.0)
			#print("Stamina Bar Visible")
		if value == 100:
			ui.change_stamina_alpha(0.0)
		stamina = clamp(value,0,100)

signal cast_spell(type: String,position: Vector3,direction: Vector2,size: float)

func _ready() -> void:
	ui.setup(health)

func _physics_process(delta: float) -> void:
	RenderingServer.global_shader_parameter_set('player_position',global_position)
	move_logic(delta)
	jump_logic(delta)
	ability_logic()
	physics_logic()
	#if Input.is_action_just_pressed("ui_accept"):
		#hit()
	move_and_slide()

func ability_logic() -> void:
	#Handling Attack 
	if Input.is_action_just_pressed("attack"):
		if weapon_active:
			godettte_skin.attack()
			$Sounds/SwordSound.play()
		else:
			godettte_skin.cast_spell()
			stop_movement(0.3,0.8)
	
	#Handling Defend
	defend =  Input.is_action_pressed("defend")
	
	#Handling Swutch Between Weapon and Magic
	if Input.is_action_just_pressed("switch_weapon") and not godettte_skin.attacking:
		weapon_active = not weapon_active
		godettte_skin.switch_weapon(weapon_active)
	
	if Input.is_action_just_pressed("switch_spell") and not godettte_skin.attacking:
		current_spell = spells[spells.keys()[(int(current_spell +1)) % len(spells)]]
		ui.update_spell(spells,current_spell)

func move_logic(delta) ->void:
	#Handling Movements Like Walking and Running
	movement_input = Input.get_vector("move_left","move_right","move_forward","move_backward").rotated(-camera.global_rotation.y)
	var is_running:bool = Input.is_action_pressed("run")
	var vel_2d = Vector2(velocity.x,velocity.z)

	if  movement_input != Vector2.ZERO:
		var speed = run_speed if is_running else base_speed
		speed =  defend_speed if defend else speed
		vel_2d += speed * delta * movement_input * 8.0
		vel_2d = vel_2d.limit_length(speed) * speed_modifier
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
		if is_running:
			godettte_skin.set_move_state("Running")
			
			#stamina -= 0.5
		else:
			godettte_skin.set_move_state("Walking")
		target_angle = -movement_input.angle() + (PI/2 + 0 )
		godettte_skin.rotation.y = rotate_toward(godettte_skin.rotation.y,target_angle,5*delta)
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO,base_speed * delta * 4.0)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
		godettte_skin.set_move_state("Idle")
	if movement_input:
		last_movement_input = movement_input.normalized()
	
	#Run Particles Logic
	run_particles.emitting = is_running and movement_input != Vector2.ZERO and is_on_floor()
	
	#Step Sound Logic
	if is_on_floor() and movement_input:
		if not $Sounds/StepSound.playing:
			$Sounds/StepSound.playing = true
	else:
		$Sounds/StepSound.playing = false

func jump_logic(delta) ->void:
	#Handling Jump
	if is_on_floor():
		if Input.is_action_just_pressed("Jump") and stamina >= 20: 
			velocity.y = -jump_velocity
			do_squash_and_strecth(1.2,0.3)
			stamina -= 20
			jump_particles.emitting = true
	else:
		godettte_skin.set_move_state("Jump")
	var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y -= gravity * delta

func stop_movement(start_duration: float,end_duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(self,"speed_modifier",0.0,start_duration)
	tween.tween_property(self,"speed_modifier",1.0,end_duration)

func hit() -> void:
	if defend:
		$Sounds/ShieldSound.play()

	elif not invul_timer.time_left:
		godettte_skin.hit()
		stop_movement(0.3,0.5)
		health -= 1
		invul_timer.start()

func do_squash_and_strecth(value: float,duration: float = 0.1) -> void:
	var tween = create_tween()
	tween.tween_property(godettte_skin,"squash_and_stretch",value,duration)
	tween.tween_property(godettte_skin,"squash_and_stretch",1.0,duration * 1.8).set_ease(Tween.EASE_OUT)

func shoot_magic(pos: Vector3):
	if current_spell == spells.FIREBALL:
		if energy >= 20:
			emit_signal("cast_spell","fireball",pos,last_movement_input,1.)
			energy -= 20
	elif current_spell == spells.HEAL:
		if energy >= 30:
			health += 1
			energy -= 30
			godettte_skin.heal_tween()

func _on_energy_recovery_timer_timeout() -> void:
	energy += 1

func _on_stamina_recovery_timer_timeout() -> void:
	stamina += 1

func physics_logic() -> void:
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider is RayCast3D:
			collider.apply_central_impulse(get_slide_collision(i).get_normal())

func _player_died() -> void:
	get_tree().reload_current_scene()


func _on_attack_pressed() -> void:
	Input.action_press("attack")

func _on_attack_released() -> void:
	Input.action_release("attack")

func _on_jump_pressed() -> void:
	Input.action_press("Jump")

func _on_jump_released() -> void:
	Input.action_release("Jump")
