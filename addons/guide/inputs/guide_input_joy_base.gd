## Base class for joystick inputs.
@tool
class_name GUIDEInputJoyBase
extends GUIDEInput

## The index of the connected joy pad to check. If -1 checks all joypads.
@export var joy_index:int = -1:
	set(value):
		if value == joy_index:
			return
		joy_index = value
		emit_changed()	

