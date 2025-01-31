extends UiPage

var _audio_bus_name_idx_mapping: Dictionary = {}


func _ready() -> void:
	Settings.load_settings()
	%Back.pressed.connect(go_back)
	call_deferred("_update_audio_sliders")

	for idx: int in range(0, AudioServer.bus_count):
		_audio_bus_name_idx_mapping[AudioServer.get_bus_name(idx)] = idx
	#print(JSON.stringify(_audio_bus_name_idx_mapping))

	for control: HSlider in %Audio.find_children("*", "HSlider"):
		control.value_changed.connect(_on_audio_hslider_value_changed.bind(control.name))


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_back"):
		get_viewport().set_input_as_handled()
		go_back()


func _on_audio_hslider_value_changed(value: float, bus_name: String) -> void:
	#print(bus_name, value / 100)
	AudioServer.set_bus_volume_db(_audio_bus_name_idx_mapping[bus_name], linear_to_db(value / 100))
	if Settings.get_value(Settings.Section.AUDIO, bus_name, null) != value:
		Settings.set_value(Settings.Section.AUDIO, bus_name, value)


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
