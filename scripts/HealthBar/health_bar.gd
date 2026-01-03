extends ProgressBar

@onready var damage_bar: ProgressBar = $DamageBar
@onready var timer: Timer = $Timer

var health := 0 : set = _set_health

func _set_health(new_health: int):
	var prev_health = health
	health = min(new_health,max_value)
	
	if health <= 0:
		queue_free()
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

func _init_health(_health: int):
	health = _health
	value = health
	max_value = health
	damage_bar.value = health
	damage_bar.max_value = health



func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(damage_bar,"value",health,0.2)
