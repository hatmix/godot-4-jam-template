## Stateful modifier which provides a virtual "mouse" cursor driven by input. The modifier
## returns the current cursor position in pixels releative to the origin of the currently
## active window. 
@tool
class_name GUIDEModifierVirtualCursor
extends GUIDEModifier

## The initial position of the virtual cursor (given in screen relative coordinates)
@export var initial_position:Vector2 = Vector2(0.5, 0.5):
	set(value):
		initial_position = value.clamp(Vector2.ZERO, Vector2.ONE)

## The scale by which the input should be scaled.
@export var scale:Vector3 = Vector3.ONE
## If true, delta time will be multiplied in addition to the scale.
@export var apply_delta_time:bool = true

## Cursor offset in resolution independent coordinates (0,0 to 1,1).
var _offset:Vector3 = Vector3.ZERO

func _begin_usage():
	_offset = Vector3(initial_position.x, initial_position.y, 0)


func _modify_input(input:Vector3, delta:float, value_type:GUIDEAction.GUIDEActionValueType) -> Vector3:
	if not input.is_finite():
		input = Vector3.ZERO
		
	input *= scale
	
	if apply_delta_time:
		input *= delta
		
	_offset = (_offset + input).clamp(Vector3.ZERO, Vector3.ONE)
	
	# Get window size, including scaling factor
	var window = Engine.get_main_loop().get_root()
	var window_size:Vector2 = window.get_screen_transform().affine_inverse() * Vector2(window.size)
	
	return Vector3(_offset.x * window_size.x, _offset.y * window_size.y, 0)

func _editor_name() -> String:
	return "Virtual Cursor"


func _editor_description() -> String:
	return "Stateful modifier which provides a virtual \"mouse\" cursor driven by input. The modifier\n" + \
			"returns the current cursor position in pixels releative to the origin of the currently \n" + \
			"active window."
