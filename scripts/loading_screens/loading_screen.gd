class_name LoadingScreen
extends CanvasLayer

var progress = []
var level
var scene_load_status = 0

@onready var loading_progress: TextureProgressBar = $LoadingProgressBar
@onready var progress_text: Label = $ProgressText

func _process(_delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(level,progress)
	loading_progress.value = floor(progress[0] * 100)
	progress_text.text =  str(floor(progress[0] * 100)) + "%"
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(level)
		get_tree().change_scene_to_packed(new_scene)
