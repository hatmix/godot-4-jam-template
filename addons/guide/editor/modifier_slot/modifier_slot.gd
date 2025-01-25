@tool
extends LineEdit
signal modifier_changed()

var modifier:GUIDEModifier:
	set(value):
		modifier = value
		
		if modifier == null:
			text = "<none>"
			tooltip_text = ""
		else:
			text = modifier._editor_name()
			tooltip_text = modifier.resource_path

	
func _can_drop_data(at_position, data) -> bool:
	if not data is Dictionary:
		return false
		
	if data.has("files"):
		for file in data["files"]:
			if ResourceLoader.load(file) is GUIDEModifier:
				return true
		
	return false	
	
	
func _drop_data(at_position, data) -> void:
	
	for file in data["files"]:
		var item = ResourceLoader.load(file) 
		if item is GUIDEModifier:
			modifier = item
			modifier_changed.emit()


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if is_instance_valid(modifier):
				EditorInterface.edit_resource(modifier)


