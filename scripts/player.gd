extends CharacterBody3D

@export var base_speed := 4.0
var movement_input:Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	movement_input = Input.get_vector("move_left","move_right","move_forward","move_backward")
	velocity = Vector3(movement_input.x,0,movement_input.y) * base_speed
	
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
