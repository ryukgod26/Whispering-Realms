extends Path3D

@export var bird_scene: PackedScene
@export var bird_count: int = 5
@export var distance_between_birds: int = 2
@export var speed: float = 5.
@export var flock_spread: float = 3.0

func _ready() -> void:
	spawn_birds()

func spawn_birds():
	for i in range(bird_count):
		var new_follower = PathFollow3D.new()
		add_child(new_follower)
		new_follower.progress = i * distance_between_birds
		new_follower.loop = true
		var new_bird = bird_scene.instantiate()
		
		new_follower.add_child(new_bird)
		var random_x = randf_range(-flock_spread, flock_spread)
		var random_y = randf_range(-flock_spread, flock_spread)
		
		new_bird.position = Vector3(random_x, random_y, 0)

func _process(delta: float) -> void:
	for follower in get_children():
		if follower is PathFollow3D:
			var bird_speed = speed + (follower.get_instance_id() % 3) 
			follower.progress += bird_speed * delta
