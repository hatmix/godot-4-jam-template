extends Control

const DEFAULT_ACTIONS: Array[String] = [
	"ui_up",
	"ui_down",
	"ui_right",
	"ui_left",
	"ui_accept",
	"ui_cancel",
]


func _ready() -> void:
	%InputPanel.visible = false
	%Back.pressed.connect(GuiTransitions.go_to.bind("Settings"))
	_init_actions()


func _init_actions() -> void:
	var actions: Array[String] = []
	for action: String in InputMap.get_actions():
		if action.begins_with("editor_") or action.begins_with("ui_"):
			continue
		actions.append(action)

	if actions.size() == 0:
		actions.append_array(DEFAULT_ACTIONS)

	for action: String in actions:
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
	%InputPanel.type = type
	%InputPanel.action = action
	%InputPanel.visible = true

	print("get new input for action %s" % action)
