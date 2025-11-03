extends Node3D


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		print(event.relative)
