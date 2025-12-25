class_name InputManager
extends Node

signal input_device_changed(device: InputDevice)

enum InputDevice { UNKNOWN, KEYBOARD_MOUSE, CONTROLLER }

@export var default_mapping_context: GUIDEMappingContext

var input_device_mapping_context: GUIDEMappingContext = load(
	"res://src/input/_template/input_device_mapping_context.tres"
)
var controller_action: GUIDEAction = load("res://src/input/_template/switch_to_controller.tres")
var keyboard_and_mouse_action: GUIDEAction = load(
	"res://src/input/_template/switch_to_keyboard_and_mouse.tres"
)
var last_input_device: InputDevice


func _ready() -> void:
	GUIDE.enable_mapping_context(default_mapping_context)
	GUIDE.enable_mapping_context(input_device_mapping_context)
	controller_action.triggered.connect(_last_used.bind(InputDevice.CONTROLLER))
	keyboard_and_mouse_action.triggered.connect(_last_used.bind(InputDevice.KEYBOARD_MOUSE))


func _last_used(device: InputDevice) -> void:
	if last_input_device != device:
		#print("input device changed: ", InputDevice.keys()[device])
		last_input_device = device
		input_device_changed.emit(device)
