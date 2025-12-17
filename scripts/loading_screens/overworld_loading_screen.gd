extends LoadingScreen

func _ready() -> void:
	level  = "res://scenes/over_world.tscn"
	ResourceLoader.load_threaded_request(level)
