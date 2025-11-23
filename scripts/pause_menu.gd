extends CanvasLayer

func _ready() -> void:
	visible = false
	get_tree().paused = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('pause') and not $"../Options".visible:
		visible = !visible
		get_tree().paused = !get_tree().paused

func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false

func _on_options_pressed() -> void:
	$"../Options".visible = true

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
