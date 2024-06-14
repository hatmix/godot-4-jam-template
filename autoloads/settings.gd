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


#region control remapping
func load_controls() -> void:
	print("Loading controls from file...")
	if not ResourceLoader.exists(CONTROLS_FILE, &"ControlsData"):
		print("No saved controls data in ", CONTROLS_FILE)
		return

	var data: ControlsData = ResourceLoader.load(CONTROLS_FILE, &"ControlsData")
	if not is_instance_valid(data):
		printerr("Failed to load controls!")
		return

	for action: String in data.controls.keys():
		if not InputMap.has_action(action):
			continue
		for event: InputEvent in data.controls[action]:
			update_action_event(action, event, false)
	print("Done loading controls from file...")


func save_controls() -> void:
	#print("save_controls called")
	var actions: Array = InputMap.get_actions()
	var data: ControlsData = ControlsData.new()
	for action: String in actions:
		if action.begins_with("editor_") or action.begins_with("ui_"):
			continue
		data.controls[action] = InputMap.action_get_events(action)
	var err: int = ResourceSaver.save(data, CONTROLS_FILE)
	if err:
		SignalBus.post_ui_message.emit(
			"Error saving controls '%s'" % str(err), Message.ICON.FAILURE
		)
	else:
		SignalBus.post_ui_message.emit("Controls saved", Message.ICON.SUCCESS)


func reset_controls() -> void:
	InputMap.load_from_project_settings()


func update_action_event(action: String, event: InputEvent, save: bool = true) -> void:
	print("remap action %s event %s" % [action, JSON.stringify(event)])
	var updated: bool = false
	var action_events: Array = InputMap.action_get_events(action)
	for action_event: InputEvent in action_events:
		# First, check for equivalent event type to update
		if event is InputEventKey and action_event is InputEventKey:
			event = event as InputEventKey
			action_event = action_event as InputEventKey
			# Clear key code entries to save the one in the event
			action_event.keycode = KEY_NONE
			action_event.physical_keycode = KEY_NONE
			action_event.unicode = 0
			if event.keycode != KEY_NONE:
				action_event.keycode = event.keycode
			else:
				action_event.physical_keycode = event.physical_keycode
			updated = true
			break
		elif event is InputEventMouseButton and action_event is InputEventMouseButton:
			event = event as InputEventMouseButton
			action_event = action_event as InputEventMouseButton
			action_event.button_index = event.button_index
			updated = true
			break
		elif event is InputEventJoypadButton and action_event is InputEventJoypadButton:
			event = event as InputEventJoypadButton
			action_event = action_event as InputEventJoypadButton
			action_event.button_index = event.button_index
			updated = true
			break
		elif event is InputEventJoypadMotion and action_event is InputEventJoypadMotion:
			event = event as InputEventJoypadMotion
			action_event = action_event as InputEventJoypadMotion
			action_event.axis = event.axis
			action_event.axis_value = event.axis_value
			updated = true
			break
		# If no equivalent type, pick similar type (key & mouse or joypad) to replace
		elif (
			(event is InputEventKey and action_event is InputEventMouseButton)
			or (event is InputEventMouseButton and action_event is InputEventKey)
			or (event is InputEventJoypadButton and action_event is InputEventJoypadMotion)
			or (event is InputEventJoypadMotion and action_event is InputEventJoypadButton)
		):
			InputMap.action_erase_event(action, action_event)
			InputMap.action_add_event(action, event)
			updated = true
			break
	# If nothing replaced, just add a new action event
	if not updated:
		InputMap.action_add_event(action, event)
	SignalBus.controls_changed.emit()
	if save:
		save_controls()


#endregion


#region settings
func load_settings() -> void:
	if _settings != null:
		return
	_init_timer()
	_settings = ConfigFile.new()
	var err: int = _settings.load(SETTINGS_FILE)
	if err:
		SignalBus.post_ui_message.emit("Loading default settings", Message.ICON.SUCCESS)
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
		SignalBus.post_ui_message.emit(
			"Error saving settings '%s'" % str(err), Message.ICON.FAILURE
		)
	else:
		print("post success message")
		SignalBus.post_ui_message.emit("Settings saved", Message.ICON.SUCCESS)


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
