extends LoadingScreen


func _ready() -> void:
	level  = "res://scenes/boss_dungeon_scene.tscn"
	ResourceLoader.load_threaded_request(level)
