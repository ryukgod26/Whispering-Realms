extends CharacterBody3D

@export var base_speed := 4.0
@export var run_speed := 6.0
var movement_input:Vector2 = Vector2.ZERO
var run_input:Vector2 = Vector2.ZERO
@onready var camera = $CameraController/Camera3D

@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_fall: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak )* -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_fall * jump_time_to_fall)) * -1.0

func _physics_process(delta: float) -> void:
	movement_input = Input.get_vector("move_left","move_right","move_forward","move_backward").rotated(-camera.global_rotation.y)
	run_input = Input.get_vector("run_left","run_right","run_forward","run_backward").rotated(-camera.global_rotation.y)
	#velocity = Vector3(movement_input.x,0,movement_input.y) * base_speed
	var vel_2d = Vector2(velocity.x,velocity.z)
	if run_input != Vector2.ZERO:
		vel_2d += run_speed * delta * run_input
		vel_2d = vel_2d.limit_length(run_speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
	elif  movement_input != Vector2.ZERO:
		vel_2d += base_speed * delta * movement_input
		vel_2d = vel_2d.limit_length(base_speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO,base_speed * delta * 4.0)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_velocity
	var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y -= gravity * delta
	print(velocity)
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
