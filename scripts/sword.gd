extends Node3D

var can_damage:bool = false

func _physics_process(_delta: float) -> void:
	if can_damage:
		var collider = $RayCast3D.get_collider()
		if collider and collider.has_method('hit'):
			collider.hit()

func change_damage(val:bool):
	if val:
		can_damage = true
	else:
		can_damage = false
	#print(can_damage)
