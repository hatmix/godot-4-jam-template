extends Control

var _is_dirty: bool = false:
	set = _set_is_dirty


func _set_is_dirty(value: bool) -> void:
	_is_dirty = value
	%Save.visible = _is_dirty


func _ready() -> void:
	%Save.visible = false
	%Save.pressed.connect(_on_save)
	%Back.pressed.connect(GuiTransitions.go_to.bind("Settings"))
	_init_actions()


func _init_actions() -> void:
	Settings.load_remap()
	for action: String in ProjectSettings.get_setting("addons/ControlsRemap/action_list"):
		#print("%s %s %s" % [action, Settings.get_action_key(action), Settings.get_action_button(action)])
		#var action_key: InputEvent = Settings.get_action_key(action)
		#var action_button: InputEvent = Settings.get_action_button(action)
		var action_label: Label = Label.new()
		action_label.text = action.to_upper().replace("_", " ")
		%Actions.add_child(action_label)
		var prompt: ActionPrompt = ActionPrompt.new()
		prompt.icon = 4 # Keyboard
		prompt.action = action
		%Actions.add_child(prompt)
		prompt = ActionPrompt.new()
		prompt.icon = 1 # XBox
		prompt.action = action
		%Actions.add_child(prompt)



func _on_save() -> void:
	Settings.save_remap()

