## Returns the magnitude of the input value.
@tool
class_name GUIDEModifierMagnitude
extends GUIDEModifier

func is_same_as(other:GUIDEModifier) -> bool:
	return other is GUIDEModifierMagnitude

func _modify_input(input:Vector3, delta:float, value_type:GUIDEAction.GUIDEActionValueType) -> Vector3:
	if not input.is_finite():
		return Vector3.INF
		
	return Vector3(input.length(), 0, 0)

func _editor_name() -> String:
	return "Magnitude"	


func _editor_description() -> String:
	return "Returns the magnitude of the input vector."
