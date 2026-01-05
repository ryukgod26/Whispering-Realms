extends CanvasLayer

#For Audio
@onready var master_slider: HSlider = $TabContainer/Audio/MasterSlider
@onready var music_slider: HSlider = $TabContainer/Audio/MusicSlider
@onready var sfx_slider: HSlider = $TabContainer/Audio/SfxSlider

#For Audio
var master_bus_index
var music_bus_index
var sfx_bus_index

func _ready() -> void:
	#For Audio
	master_bus_index = AudioServer.get_bus_index("Master")
	music_bus_index = AudioServer.get_bus_index("Music")
	sfx_bus_index = AudioServer.get_bus_index("SFX")
	
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_index))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index))
	
	#For GamePlay
	$TabContainer/Gameplay/Sensitivity.value = GameSettings.mouse_sensitivity
	$TabContainer/Gameplay/InvertY.button_pressed = GameSettings.invert_y_axis
	$TabContainer/Gameplay/Fov.value = GameSettings.fov
	
	$TabContainer/Gameplay/GlassIntensity.value = $ColorRect.material.get_shader_parameter('glass_intensity')
	$".".visible = false
	
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_WINDOWED:
			$TabContainer/Video/DisplayMode.select(0)
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			$TabContainer/Video/DisplayMode.select(1)
		_:
			$TabContainer/Video/DisplayMode.select(-1)
	
	match DisplayServer.window_get_size():
		Vector2i(1600,900):
			$TabContainer/Video/Resolution.select(0)
		Vector2i(1920,1080):
			$TabContainer/Video/Resolution.select(1)
		Vector2i(2560,1440):
			$TabContainer/Video/Resolution.select(2)
		_:
			$TabContainer/Video/Resolution.select(-1)
	
	match DisplayServer.window_get_vsync_mode():
		DisplayServer.VSYNC_DISABLED:
			$TabContainer/Video/vsync.select(0)
		DisplayServer.VSYNC_ENABLED:
			$TabContainer/Video/vsync.select(1)
		DisplayServer.VSYNC_ADAPTIVE:
			$TabContainer/Video/vsync.select(2)
		DisplayServer.VSYNC_MAILBOX:
			$TabContainer/Video/vsync.select(3)
		_:
			$TabContainer/Video/vsync.select(-1)
	
 
#For Video

func _on_display_mode_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		_:
			pass
	$OptionSound.pitch_scale = randf_range(0.9, 1.1)
	$OptionSound.play()

func _on_resolution_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1600,900))
		1:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		2:
			DisplayServer.window_set_size(Vector2i(2560,1440))
		_:
			pass
	$OptionSound.pitch_scale = randf_range(0.9, 1.1)
	$OptionSound.play()

func _on_vsync_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		1:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		2:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
		3:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)
	$OptionSound.pitch_scale = randf_range(0.9, 1.1)
	$OptionSound.play()

func _on_anti_aliasing_item_selected(index: int) -> void:
	var vp = get_viewport()
	
	# Reset everything first to ensure no conflicts
	vp.msaa_3d = Viewport.MSAA_DISABLED
	vp.screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
	vp.use_taa = false
	match index:
		0:
			pass
		1:
			vp.screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA
		2:
			vp.msaa_3d = Viewport.MSAA_2X
		3:
			vp.msaa_3d = Viewport.MSAA_4X
		4:
			vp.msaa_3d = Viewport.MSAA_8X
		5:
			vp.use_taa = true
	$OptionSound.pitch_scale = randf_range(0.9, 1.1)
	$OptionSound.play()

func select_vsync_mode() -> void:
	var vsync_mode = DisplayServer.window_get_vsync_mode(0)
	if vsync_mode.VSYNC_DISABLED:
		$TabContainer/Video/vsync.selected = 0
	elif vsync_mode.VSYNC_ENABLED:
		$TabContainer/Video/vsync.selected = 1
	elif vsync_mode.VSYNC_ADAPTIVE:
		$TabContainer/Video/vsync.selected = 2
	elif vsync_mode.VSYNC_MAILBOX:
		$TabContainer/Video/vsync.selected = 3

func select_anti_aliasing() -> void:
	var vp = get_viewport()
	if vp.msaa_3d == Viewport.MSAA_4X:
		$TabContainer/Video/AntiAliasing.selected = 3
	elif vp.msaa_3d == Viewport.MSAA_2X:
		$TabContainer/Video/AntiAliasing.selected = 2
	elif vp.screen_space_aa == Viewport.SCREEN_SPACE_AA_FXAA:
		$TabContainer/Video/AntiAliasing.selected = 1
	else:
		$TabContainer/Video/AntiAliasing.selected = 0


#For Audio
func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_index,linear_to_db(value))
	AudioServer.set_bus_mute(master_bus_index,value < 0.05)
	
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_index,linear_to_db(value))
	AudioServer.set_bus_mute(music_bus_index,value < 0.05)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index,linear_to_db(value))
	AudioServer.set_bus_mute(sfx_bus_index,value < 0.05)


#For GamePlay

func _on_sensitivity_value_changed(value: float) -> void:
	GameSettings.mouse_sensitivity = value

func _on_invert_y_toggled(toggled_on: bool) -> void:
	GameSettings.invert_y_axis = toggled_on

func _on_fov_value_changed(value: float) -> void:
	GameSettings.fov = value

func _on_back_pressed() -> void:
	$".".visible = false

func _on_glass_intensity_value_changed(value: float) -> void:
	$ColorRect.material.set_shader_parameter('glass_intensity',value)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		
		var hovered_control = get_viewport().gui_get_hovered_control()
		
		if hovered_control and hovered_control is Button:
			
			if !hovered_control.disabled:
				$ClickSound.pitch_scale = randf_range(0.9, 1.1)
				$ClickSound.play()
