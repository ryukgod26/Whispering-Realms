class_name Level
extends Node3D

const scenes = {
	'dungeon':"res://scenes/dungeon.tscn",
	'overworld': "res://scenes/over_world.tscn"
}

var fireball_scene: PackedScene =  preload("res://scenes/fireball.tscn")

func _ready() -> void:
	for entity in $Entities.get_children():
		if entity.has_signal("cast_spell"):
			entity.connect("cast_spell",create_fireball)

#func _on_player_cast_spell(type: String, position: Vector3, direction: Vector2, size: float) -> void:
	#var fireball = fireball_scene.instantiate()
	#$Projectiles.add_child(fireball)
	#fireball.global_position = position
	#fireball.direction = direction

func create_fireball(_type: String, fireball_position: Vector3, direction: Vector2, size: float) -> void:
	var fireball = fireball_scene.instantiate()
	$Projectiles.add_child(fireball)
	fireball.global_position = fireball_position
	fireball.direction = direction
	fireball.setup(size)

func switch_level(level: String):
	call_deferred('_switch_level',level)

func _switch_level(level: String):
	get_tree().change_scene_to_file(scenes[level])
