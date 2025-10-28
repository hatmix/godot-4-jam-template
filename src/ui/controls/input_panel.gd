extends PopupPanel

var item: GUIDERemapper.ConfigItem
var input: GUIDEInput
var for_joypad: bool = false

@onready var _input_detector: GUIDEInputDetector = %GUIDEInputDetector


func _ready() -> void:
	pass


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED:
		var devices: Array[GUIDEInputDetector.DeviceType]
		if not visible:
			_input_detector.abort_detection()
			return
		if not item:
			push_error("InputPanel missing GUIDERemapper.ConfigItem")
			visible = false
			return
		if for_joypad:
			%KeyboardMouseLabel.visible = false
			%JoypadLabel.visible = true
			devices = [GUIDEInputDetector.DeviceType.JOY]
			_input_detector.detect(item.value_type, devices)
		else:
			%KeyboardMouseLabel.visible = true
			%JoypadLabel.visible = false
			devices = [GUIDEInputDetector.DeviceType.MOUSE, GUIDEInputDetector.DeviceType.KEYBOARD]
		_input_detector.detect(item.value_type, devices)
		input = await _input_detector.input_detected
		visible = false


func _input(event: InputEvent) -> void:
	if event is InputEventAction and (event.is_action("ui_cancel") or event.is_action("ui_back")):
		get_viewport().set_input_as_handled()
		visible = false
