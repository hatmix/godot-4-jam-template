extends Node

enum SECTION { AUDIO }

const CONTROLS_FILE: String = "user://controls.tres"
const SETTINGS_FILE: String = "user://settings.cfg"
const DEFAULT_SETTINGS_FILE: String = "res://default_settings.cfg"

# Timer is used to prevent fast repeated saving of cfg files
var _timer: Timer
static var _settings: ConfigFile


func _ready() -> void:
	Globals.controls_changed.connect(save_controls)


#region control remapping
func load_controls() -> GUIDERemappingConfig:
	print("Loading controls from file...")
	if not ResourceLoader.exists(CONTROLS_FILE):
		print("No saved controls data in ", CONTROLS_FILE)
		return GUIDERemappingConfig.new()

	var data: GUIDERemappingConfig = ResourceLoader.load(CONTROLS_FILE)
	if not is_instance_valid(data):
		printerr("Failed to load controls!")
		reset_controls()
		return GUIDERemappingConfig.new()
	print(data)
	return data


func save_controls(data: GUIDERemappingConfig) -> void:
	var err: int = ResourceSaver.save(data, CONTROLS_FILE)
	if err:
		Globals.post_ui_message.emit("Error saving controls '%s'" % str(err), Message.ICON.FAILURE)
	else:
		Globals.post_ui_message.emit("Controls saved", Message.ICON.SUCCESS)
	data.take_over_path(CONTROLS_FILE)


func reset_controls() -> void:
	save_controls(GUIDERemappingConfig.new())


#endregion


#region settings
func load_settings() -> void:
	if _settings != null:
		return
	_init_timer()
	_settings = ConfigFile.new()
	var err: int = _settings.load(SETTINGS_FILE)
	if err:
		Globals.post_ui_message.emit("Loading default settings", Message.ICON.SUCCESS)
		err = _settings.load(DEFAULT_SETTINGS_FILE)
		if not err:
			err = _settings.save(SETTINGS_FILE)


func _init_timer() -> void:
	_timer = Timer.new()
	_timer.one_shot = true
	_timer.timeout.connect(save_settings)
	add_child(_timer)


func save_settings() -> void:
	var err: int = _settings.save(SETTINGS_FILE)
	if err:
		print("post failure message")
		Globals.post_ui_message.emit("Error saving settings '%s'" % str(err), Message.ICON.FAILURE)
	else:
		print("post success message")
		Globals.post_ui_message.emit("Settings saved", Message.ICON.SUCCESS)


func get_value(section: SECTION, key: String, default: Variant) -> Variant:
	load_settings()
	var section_name: String = SECTION.keys()[section]
	return _settings.get_value(section_name.to_pascal_case(), key, default)


func set_value(section: SECTION, key: String, value: Variant) -> void:
	load_settings()
	var section_name: String = SECTION.keys()[section]
	_settings.set_value(section_name.to_pascal_case(), key, value)
	_timer.start(1.0)
#endregion
