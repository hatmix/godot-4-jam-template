extends Control

var _is_dirty: bool = false:
	set = _set_is_dirty


func _set_is_dirty(value: bool) -> void:
	_is_dirty = value
	%Save.visible = _is_dirty


func _ready() -> void:
	#%Save.visible = false
	#%Save.pressed.connect(_on_save)
	%Back.pressed.connect(GuiTransitions.go_to.bind("Settings"))
	_init_actions()


func _init_actions() -> void:
	Settings.load_remap()
	for action: String in ProjectSettings.get_setting("addons/ControlsRemap/action_list"):
		#print("%s %s %s" % [action, Settings.get_action_key(action), Settings.get_action_button(action)])
		#var action_key: InputEvent = Settings.get_action_key(action)
		#var action_button: InputEvent = Settings.get_action_button(action)
		var action_label: Label = Label.new()
		action_label.text = action.capitalize()
		%Actions.add_child(action_label)

		%Actions.add_child(_build_button(action, InputPrompt.Icons.KEYBOARD))
		%Actions.add_child(_build_button(action, PromptManager.joy_icons))


func _build_button(action: String, icon_type: InputPrompt.Icons) -> Button:
	var prompt: ActionPrompt = ActionPrompt.new()
	prompt.icon = icon_type  # 1-3 controller families, 4 = Keyboard
	prompt.action = action
	prompt.mouse_filter = Control.MOUSE_FILTER_IGNORE
	prompt.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	var button: Button = Button.new()
	button.flat = true
	button.pressed.connect(_get_new_input_for_action.bind(action, icon_type))
	button.add_child(prompt)
	return button


func _get_new_input_for_action(action: String, type: InputPrompt.Icons) -> void:
	# TODO: get the new input
	print("get new input for action %s" % action)


func _on_save() -> void:
	Settings.save_remap()
