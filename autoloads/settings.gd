extends Node

enum SECTION { AUDIO }

const CONTROLS_FILE: String = "user://controls.tres"
const SETTINGS_FILE: String = "user://settings.cfg"
const DEFAULT_SETTINGS_FILE: String = "res://default_settings.cfg"

# Timer is used to prevent fast repeated saving of cfg files
var _timer: Timer
static var _settings: ConfigFile


func _ready() -> void:
	load_controls()


func load_controls() -> void:
	if not ResourceLoader.exists(CONTROLS_FILE, &"ControlsData"):
		print("No saved controls data in ", CONTROLS_FILE)
		return

	var data: ControlsData = ResourceLoader.load(CONTROLS_FILE, &"ControlsData")
	if not is_instance_valid(data):
		printerr("Failed to load controls!")
		return

	for action: String in data.controls.keys():
		# TODO: find each mapping to replace, not erase all
		InputMap.action_erase_events(action)
		for event: InputEvent in data.controls[action]:
			InputMap.action_add_event(action, event)


func save_controls() -> void:
	var actions: Array = InputMap.get_actions()
	var data: ControlsData = ControlsData.new()
	for action: String in actions:
		if action.begins_with("editor_") or action.begins_with("ui_"):
			continue
		data.controls[action] = InputMap.action_get_events(action)
		var err: int = ResourceSaver.save(data, CONTROLS_FILE)
		if err:
			SignalBus.post_message.emit(
				"Error saving controls '%s'" % str(err), Message.ICON.FAILURE
			)
		else:
			SignalBus.post_message.emit("Controls saved", Message.ICON.SUCCESS)


func reset_controls() -> void:
	InputMap.load_from_project_settings()


func remap_control(action: String, event: InputEvent) -> void:
	print("remap %s event %s" % [action, JSON.stringify(event)])


func load_settings() -> void:
	if _settings != null:
		return
	_init_timer()
	_settings = ConfigFile.new()
	var err: int = _settings.load(SETTINGS_FILE)
	if err:
		SignalBus.post_message.emit("Loading default settings", Message.ICON.SUCCESS)
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
		SignalBus.post_message.emit("Error saving settings '%s'" % str(err), Message.ICON.FAILURE)
	else:
		print("post success message")
		SignalBus.post_message.emit("Settings saved", Message.ICON.SUCCESS)


func get_value(section: SECTION, key: String, default: Variant) -> Variant:
	load_settings()
	var section_name: String = SECTION.keys()[section]
	return _settings.get_value(section_name.to_pascal_case(), key, default)


func set_value(section: SECTION, key: String, value: Variant) -> void:
	load_settings()
	var section_name: String = SECTION.keys()[section]
	_settings.set_value(section_name.to_pascal_case(), key, value)
	_timer.start(1.0)
