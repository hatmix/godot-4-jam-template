extends Control

const DEFAULT_ACTIONS: Array[String] = [
	"ui_up",
	"ui_down",
	"ui_right",
	"ui_left",
	"ui_accept",
	"ui_cancel",
]

var web_keyboard_icon: Texture2D = preload("res://ui/assets/icons/input_devices/keyboard.svg")


func _ready() -> void:
	%InputPanel.visible = false
	%Back.pressed.connect(_on_back)
	if OS.get_name() == "Web":
		%KeyboardMouse.texture = web_keyboard_icon
	_init_actions()
	# uncomment for working on this scene directly
	#GuiTransitions.go_to(name)


func _input(_event: InputEvent) -> void:
	# $GuiTransition._status is non-zero while transition is active
	if visible and not $GuiTransition._status and Input.is_action_just_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		GuiTransitions.go_to("Settings")


func _on_back() -> void:
	if get_tree().paused == true:
		GuiTransitions.go_to("PauseMenu")
	else:
		GuiTransitions.go_to("MainMenu")


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
		action_label.custom_minimum_size.x = %HeaderRow.custom_minimum_size.x
		action_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		action_label.text = action.capitalize()
		%Actions.add_child(action_label)

		%Actions.add_child(_build_button(action, _get_event_for_action(action)))
		var joypad_event: InputEvent = _get_event_for_action(action, true)
		%Actions.add_child(_build_button(action, joypad_event, true))


func _get_event_for_action(action: String, for_joypad: bool = false) -> Variant:
	var events: Array = InputMap.action_get_events(action)
	for event: InputEvent in events:
		if for_joypad and (event is InputEventJoypadButton or event is InputEventJoypadMotion):
			#print("found action %s event for joypad: %s" % [action, JSON.stringify(event)])
			return event
		if not for_joypad and (event is InputEventKey or event is InputEventMouseButton):
			#print("found action %s event for keyboard/mouse: %s" % [action, JSON.stringify(event)])
			return event
	return


func _build_button(action: String, event: InputEvent, for_joypad: bool = false) -> Button:
	var button: InputEventButton = InputEventButton.new()
	button.icon_set = EventIconMapping.IconSet.KENNEY_1_BIT
	button.input_event = event
	button.expand_icon = true
	button.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	button.set_icon_alignment(HORIZONTAL_ALIGNMENT_CENTER)
	button.set_vertical_icon_alignment(VERTICAL_ALIGNMENT_CENTER)
	if for_joypad:
		button.custom_minimum_size.x = %Controller.size.x
	else:
		button.custom_minimum_size.x = %KeyboardMouse.size.x
	button.flat = true
	button.pressed.connect(_get_new_input_for_action.bind(action, button, for_joypad))
	return button


func _get_new_input_for_action(
	action: String, button: InputEventButton, for_joypad: bool = false
) -> void:
	%InputPanel.for_joypad = for_joypad
	%InputPanel.action = action
	%InputPanel.visible = true
	#print("get new input for action %s" % action)

	await SignalBus.controls_changed
	button.input_event = _get_event_for_action(action, for_joypad)
