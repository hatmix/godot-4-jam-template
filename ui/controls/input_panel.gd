extends PopupPanel

var action: String
var for_joypad: bool = false


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
		if for_joypad:
			%KeyboardMouseLabel.visible = false
			%JoypadLabel.visible = true
		else:
			%KeyboardMouseLabel.visible = true
			%JoypadLabel.visible = false


func _input(event: InputEvent) -> void:
	if event is InputEventAction and event.is_action("ui_cancel"):
		visible = false

	if not for_joypad:
		if event is InputEventKey or event is InputEventMouseButton:
			if event.is_pressed():
				Settings.update_action_event(action, event)
				visible = false
				return
	elif event is InputEventJoypadButton:
		if event.is_pressed():
			Settings.update_action_event(action, event)
			visible = false
			return
	elif event is InputEventJoypadMotion:
		event = event as InputEventJoypadMotion
		if abs(event.axis_value) > InputMap.action_get_deadzone(action):
			Settings.update_action_event(action, event)
			visible = false
			return
