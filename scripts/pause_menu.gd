extends CanvasLayer

func _ready() -> void:
	visible = false
	get_tree().paused = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('pause') and not $"../Options".visible:
		visible = !visible
		get_tree().paused = !get_tree().paused
		if visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_options_pressed() -> void:
	$"../Options".visible = true

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_visibility_changed() -> void:
	if visible:
		$AnimationPlayer.play("pause_menu_open")


func _on_save_pressed() -> void:
	SaveManager.save_game()

func _on_load_pressed() -> void:
	SaveManager.load_game()
