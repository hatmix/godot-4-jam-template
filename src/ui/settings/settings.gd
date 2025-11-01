extends UiPage

var _audio_bus_name_idx_mapping: Dictionary = {}


func _ready() -> void:
	Settings.load_settings()
	%Back.pressed.connect(go_back)
	_init_audio_sliders()
	_update_audio_sliders.call_deferred()
	_init_display()
	_update_display.call_deferred()


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_back"):
		get_viewport().set_input_as_handled()
		go_back()


#region Audio bus volumes
func _on_audio_hslider_value_changed(value: float, bus_name: String) -> void:
	#print(bus_name, value / 100)
	AudioServer.set_bus_volume_db(_audio_bus_name_idx_mapping[bus_name], linear_to_db(value / 100))
	if Settings.get_value(Settings.Section.AUDIO, bus_name, null) != value:
		Settings.set_value(Settings.Section.AUDIO, bus_name, value)


func _init_audio_sliders() -> void:
	for idx: int in range(0, AudioServer.bus_count):
		_audio_bus_name_idx_mapping[AudioServer.get_bus_name(idx)] = idx
	#print(JSON.stringify(_audio_bus_name_idx_mapping))

	for control: HSlider in %Audio.find_children("*", "HSlider"):
		control.value_changed.connect(_on_audio_hslider_value_changed.bind(control.name))


func _update_audio_sliders() -> void:
	for bus_name: String in _audio_bus_name_idx_mapping:
		var engine_level: float = db_to_linear(
			AudioServer.get_bus_volume_db(_audio_bus_name_idx_mapping[bus_name])
		)
		var settings_level: float = Settings.get_value(
			Settings.Section.AUDIO, bus_name, engine_level * 100
		)
		var control: Slider = %Audio.find_child(bus_name)
		if control:
			control.value = int(settings_level)
#endregion


func _on_ui_scale_value_changed(value: float) -> void:
	get_viewport().content_scale_factor = value
	if Settings.get_value(Settings.Section.DISPLAY, "ui_scale", 1.0) != value:
		Settings.set_value(Settings.Section.DISPLAY, "ui_scale", value)


func _init_display() -> void:
	%UiScale.value_changed.connect(_on_ui_scale_value_changed)

	
func _update_display() -> void:
	var settings_level: Variant = Settings.get_value(
		Settings.Section.DISPLAY, "ui_scale", null
	)
	if settings_level:
		get_viewport().content_scale_factor = settings_level
	%UiScale.value = get_viewport().content_scale_factor
