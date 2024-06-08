extends PopupPanel

var action: String
var type: InputPrompt.Icons


func _ready() -> void:
	pass


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED:
		if not visible:
			action = ""
			return
		if action == "":
			printerr("InputPanel missing action")
			visible = false
			return
		if type == 4:
			%KeyboardMouseLabel.visible = true
			%JoypadLabel.visible = false
		else:
			%KeyboardMouseLabel.visible = false
			%JoypadLabel.visible = true


func _input(event: InputEvent) -> void:
	if event is InputEventAction and event.is_action("ui_cancel"):
		visible = false

	if type == InputPrompt.Icons.KEYBOARD:
		if event is InputEventKey or event is InputEventMouseButton:
			Settings.remap_control(action, event)
			visible = false
			return
	elif event is InputEventJoypadButton:
		Settings.remap_control(action, event)
		visible = false
		return
	elif event is InputEventJoypadMotion:
		event = event as InputEventJoypadMotion
		if abs(event.axis_value) > InputMap.action_get_deadzone(action):
			Settings.remap_control(action, event)
			visible = false
			return
