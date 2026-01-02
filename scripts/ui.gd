extends Control

@onready var heart_container = $Hearts/MarginContainer/HBoxContainer
var heart_scene = preload("res://scenes/heart.tscn")
var fire_texture = preload("res://assets/ui/fire.png")
var heal_texture = preload("res://assets/ui/heal.png")
@onready var spell_texture = $Spells/MarginContainer/TextureRect
@onready var energybar: TextureProgressBar = $EnergyBar/MarginContainer/energybar
@onready var stamina_progress_bar: TextureProgressBar = $StaminaBar/CenterContainer/MarginContainer/StaminaProgressBar
@onready var fill: TextureRect = $StaminaBar/CenterContainer/MarginContainer/Fill


func setup(val: int) -> void:
	for i in val:
		var heart = heart_scene.instantiate()
		heart_container.add_child(heart)
		heart.change_alpha(1.0)
		await get_tree().create_timer(0.4).timeout

func update_health(value: int, direction: int) -> void:
	for heart in heart_container.get_children():
		heart.queue_free()
	if direction < 0:
		for i in value:
			var heart = heart_scene.instantiate()
			heart_container.add_child(heart)
		var loosen_heart = heart_scene.instantiate()
		heart_container.add_child(loosen_heart)
		loosen_heart.change_alpha(0.0)
	else:
		for i in value -1 :
			var heart = heart_scene.instantiate()
			heart_container.add_child(heart)
		var gained_heart = heart_scene.instantiate()
		heart_container.add_child(gained_heart)
		gained_heart.change_alpha(1.0)

func update_spell(spells, current_spell) -> void:
	if current_spell == spells.FIREBALL:
		spell_texture.texture = fire_texture
	elif current_spell == spells.HEAL:
		spell_texture.texture = heal_texture
	else:
		print("No a Valid Spell")
 
func update_energy(val: int) -> void:
	energybar.value = val

func update_stamina(current: int,target: int) -> void:
	var tween = create_tween()
	tween.tween_method(_change_stamina,current,target,0.2)

func _change_stamina(val: float):
	#stamina_progress_bar.value = val
	val = val/100
	fill.material.set_shader_parameter("fill_value",val)

func change_stamina_alpha(val: float) -> void:
	var tween = create_tween()
	tween.tween_method(_change_alpha,1-val,val,0.2)

func _change_alpha(val: float):
	stamina_progress_bar.modulate.a = val
