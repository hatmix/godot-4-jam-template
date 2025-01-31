extends Control

var _audio_bus_name_idx_mapping: Dictionary = {}
var ui: Node


func _ready() -> void:
	Settings.load_settings()
	%Back.pressed.connect(_on_back)
	call_deferred("_update_audio_sliders")

	for idx: int in range(0, AudioServer.bus_count):
		_audio_bus_name_idx_mapping[AudioServer.get_bus_name(idx)] = idx
	#print(JSON.stringify(_audio_bus_name_idx_mapping))

	for control: HSlider in %Audio.find_children("*", "HSlider"):
		control.value_changed.connect(_on_audio_hslider_value_changed.bind(control.name))


func _input(_event: InputEvent) -> void:
	if visible and Input.is_action_just_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_on_back()


func _on_back() -> void:
	if ui:
		if get_tree().paused == true:
			ui.go_to("PauseMenu")
		else:
			ui.go_to("MainMenu")


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
