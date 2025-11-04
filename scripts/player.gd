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
		
func _physics_process(delta: float) -> void:
	move_logic(delta)
	jump_logic(delta)
	ability_logic()
	#print(velocity)
	move_and_slide()

	'''
	const SPEED = 5.0
	const JUMP_VELOCITY = 4.5
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left","move_right","move_forward","move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	'''


func ability_logic() -> void: 
	if Input.is_action_just_pressed("attack"):
		godettte_skin.attack()
	
	defend =  Input.is_action_pressed("defend")

func move_logic(delta) ->void:
	movement_input = Input.get_vector("move_left","move_right","move_forward","move_backward").rotated(-camera.global_rotation.y)
	var is_running:bool = Input.is_action_pressed("run")
	var vel_2d = Vector2(velocity.x,velocity.z)

	if  movement_input != Vector2.ZERO:
		var speed = run_speed if is_running else base_speed
		speed =  defend_speed if defend else speed
		vel_2d += speed * delta * movement_input
		vel_2d = vel_2d.limit_length(speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
		if is_running:
			godettte_skin.set_move_state("Running")
		else:
			godettte_skin.set_move_state("Walking")
		target_angle = -movement_input.angle() + (PI/2 + 0 )
		godettte_skin.rotation.y = rotate_toward(godettte_skin.rotation.y,target_angle,5*delta)
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO,base_speed * delta * 4.0)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
		godettte_skin.set_move_state("Idle")
		
		
func jump_logic(delta) ->void:
	if is_on_floor():
		if Input.is_action_just_pressed("Jump"): 
			velocity.y = -jump_velocity
	else:
		godettte_skin.set_move_state("Jump")
	var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y -= gravity * delta
