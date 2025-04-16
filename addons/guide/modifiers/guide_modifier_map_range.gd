@tool
## Maps an input range to an output range and optionally clamps the output.
class_name GUIDEModifierMapRange
extends GUIDEModifier

## Should the output be clamped to the range?
@export var apply_clamp:bool = true

## The minimum input value
@export var input_min:float = 0.0

## The maximum input value
@export var input_max:float = 1.0

## The minimum output value
@export var output_min:float = 0.0

## The maximum output value
@export var output_max:float = 1.0

## Apply modifier to X axis
@export var x:bool = true

## Apply modifier to Y axis
@export var y:bool = true

## Apply modifier to Z axis
@export var z:bool = true

var _omin:float
var _omax:float

func _begin_usage():
	# we calculate the min and max of the output range here, so we can use them later and don't have to
	# recalculate them every time the modifier is used
	_omin = min(output_min, output_max)
	_omax = max(output_min, output_max)

func _modify_input(input:Vector3, delta:float, value_type:GUIDEAction.GUIDEActionValueType) -> Vector3:
	if not input.is_finite():
		return Vector3.INF
		
	var x_value:float = remap(input.x, input_min, input_max, output_min, output_max)
	var y_value:float = remap(input.y, input_min, input_max, output_min, output_max)
	var z_value:float = remap(input.z, input_min, input_max, output_min, output_max)
	
	if apply_clamp:
		# clamp doesn't handle reverse ranges, so we need to use our calculated normalized output range
		# to clamp the output values
		x_value = clamp(x_value, _omin, _omax)
		y_value = clamp(y_value, _omin, _omax)
		z_value = clamp(z_value, _omin, _omax)

	# Return vector with enabled axes set, others unchanged
	return Vector3(
		x_value if x else input.x,
		y_value if y else input.y,
		z_value if z else input.z,
	)


func _editor_name() -> String:
	return "Map Range"


func _editor_description() -> String:
	return "Maps an input range to an output range and optionally clamps the output"
