extends Node

const SAVE_PATH := "user://save.json"
var pending_load_data = null

func _ready() -> void:
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node):
	if pending_load_data and node.is_in_group("Player"):
		_apply_player_data_immedately(node,pending_load_data)

func _apply_player_data_immedately(player,data):
	player.health = data["health"]
	player.energy = data["energy"]
	player.stamina = data["stamina"]
	player.current_spell = data["current_spell"]
	player.weapon_active = data["weapon_active"]
	player.defend = data["defend"]
	
	player.global_position = Vector3(data["pos_x"], data["pos_y"], data["pos_z"])
	player.rotation = Vector3(data["rotation_x"], data["rotation_y"], data["rotation_z"])
	
	if player.camera:
		player.camera.global_position = Vector3(data["camera_pos_x"], data["camera_pos_y"], data["camera_pos_z"])
		player.camera.rotation = Vector3(data["camera_rot_x"], data["camera_rot_y"], data["camera_rot_z"])
	
	if player.ui:
		player.ui.update_spell(player.spells, player.current_spell)
	
	if player.has_node("godettte_skin"):
		player.godettte_skin.switch_weapon(player.weapon_active)
	
	pending_load_data = null
	print("Player data restored via node_added signal")

func save_game():
	var player = get_tree().get_first_node_in_group("Player")
	
	if player == null:
		print("Player Not FOund in Scene")
		return
	var save_data ={
		"health": player.health,
		"energy": player.energy,
		"stamina": player.stamina,
		"current_spell": player.current_spell,
		"defend": player.defend,
		"weapon_active": player.weapon_active,
		"pos_x": player.global_position.x,
		"pos_y": player.global_position.y,
		"pos_z": player.global_position.z,
		"rotation_x": player.rotation.x,
		"rotation_y": player.rotation.y,
		"rotation_z": player.rotation.z,
		"camera_pos_x": player.camera.global_position.x,
		"camera_pos_y": player.camera.global_position.y,
		"camera_pos_z": player.camera.global_position.z,
		"camera_rot_x": player.camera.rotation.x,
		"camera_rot_y": player.camera.rotation.y,
		"camera_rot_z": player.camera.rotation.z,
		"current_scene": get_tree().current_scene.scene_file_path,
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json_string = JSON.stringify(save_data)
	file.store_string(json_string)
	file.close()
	print("Game Saved")

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("No Save File Found")
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	var json = JSON.new()
	var error = json.parse(content)
	
	if error == OK:
		var data = json.data
		_apply_save_data(data)
	else:
		print("JSON Parse Error")

func _apply_save_data(data):
	if get_tree().current_scene.scene_file_path != data["current_scene"]:
		get_tree().change_scene_to_file(data["current_scene"])
		await get_tree().process_frame
		await get_tree().process_frame 
		await get_tree().create_timer(0.1).timeout
	
	var player = await _get_player_with_retry()
	
	if player:
		player.health = data["health"]
		player.energy = data["energy"]
		player.stamina = data["stamina"]
		player.current_spell = data["current_spell"]
		player.weapon_active = data["weapon_active"]
		player.defend = data["defend"]
		
		player.global_position = Vector3(data["pos_x"],data["pos_y"],data["pos_z"])
		player.rotation = Vector3(data["rotation_x"],data["rotation_y"],data["rotation_z"])
		#player.rotation.y = data['rotation_y']
		
		if player.camera:
			player.camera.global_position = Vector3(data["camera_pos_x"],data["camera_pos_y"],data["camera_pos_z"])
			#player.camera.rotation = Vector3(data["camera_rot_x"],data["camera_rot_y"],data["camera_rot_z"])
		if player.ui:
			#ui.update_health(player.health)
			player.ui.update_spell(player.spells,player.current_spell)
		player.godettte_skin.switch_weapon(player.weapon_active)

func _get_player_with_retry(max_attempts: int = 5) -> Node:
	for i in range(max_attempts):
		var player = get_tree().get_first_node_in_group("Player")
		if player:
			return player
		await get_tree().process_frame
	return null
