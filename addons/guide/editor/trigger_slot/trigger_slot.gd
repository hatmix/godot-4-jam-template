@tool
extends Control
signal trigger_changed()

@onready var _line_edit:LineEdit = %LineEdit

var trigger:GUIDETrigger:
	set(value):
		trigger = value
		if trigger == null:
			_line_edit.text = "<none>"
			_line_edit.tooltip_text = ""
		else:
			_line_edit.text = trigger._editor_name()
			_line_edit.tooltip_text = trigger.resource_path
			
	
func _can_drop_data(at_position, data) -> bool:
	if not data is Dictionary:
		return false
		
	if data.has("files"):
		for file in data["files"]:
			if ResourceLoader.load(file) is GUIDETrigger:
				return true
		
	return false	
	
	
func _drop_data(at_position, data) -> void:
	
	for file in data["files"]:
		var item = ResourceLoader.load(file) 
		if item is GUIDETrigger:
			trigger = item
			trigger_changed.emit()



func _on_line_edit_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if is_instance_valid(trigger):
				EditorInterface.edit_resource(trigger)
