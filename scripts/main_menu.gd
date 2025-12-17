extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/overworld_loading_screen.tscn")


func _on_option_pressed() -> void:
	$Options.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()
