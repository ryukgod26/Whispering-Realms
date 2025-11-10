extends Node3D

var can_damage

func _physics_process(_delta: float) -> void:
	if can_damage:
		var collider = $RayCast3D.get_collider()
		if collider and collider.has_method('hit'):
			collider.hit()

func damage_toggle(val:bool):
	can_damage = val
 
