extends Node3D

@export var horizontal_acceleration := 2.0
@export var vertical_acceleration := 1.0
@export var mouse_acceleration := 0.005
@export var min_limit_x: float
@export var max_limit_x: float
@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	camera.fov = GameSettings.fov

func _process(delta: float) -> void:
	var joy_dir = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	rotate_from_vector(joy_dir * delta * Vector2(horizontal_acceleration,vertical_acceleration))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_from_vector(event.relative * mouse_acceleration)

func rotate_from_vector(v:Vector2):
	if v.length() == 0: return
	rotation.y -= v.x * GameSettings.mouse_sensitivity
	if GameSettings.invert_y_axis:
		rotation.x += v.y
	else:
		rotation.x -= v.y
	rotation.x = clamp(rotation.x,min_limit_x,max_limit_x)
	#rotation.x = clamp(rotation.x,deg_to_rad(-90),deg_to_rad(90))
