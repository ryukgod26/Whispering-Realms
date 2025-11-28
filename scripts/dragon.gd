extends Enemy


func _ready() -> void:
	health = 20
	detection_radius = 90


func _on_attack_timer_timeout() -> void:
	pass
