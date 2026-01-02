extends LoadingScreen

func _ready() -> void:
	level  = "res://scenes/dungeon.tscn"
	ResourceLoader.load_threaded_request(level) 
