extends Level


func _on_door_area_body_entered(_body: Node3D) -> void:
	switch_level('overworld')


func _on_boss_area_body_entered(_body: Node3D) -> void:
	switch_level('boss_dungeon')
