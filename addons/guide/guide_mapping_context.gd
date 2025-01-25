@tool
@icon("res://addons/guide/guide_mapping_context.svg")
class_name GUIDEMappingContext
extends Resource

const GUIDESet = preload("guide_set.gd")

## The display name for this mapping context during action remapping 
@export var display_name:String:
	set(value):
		if value == display_name:
			return
		display_name = value
		emit_changed()

## The mappings. Do yourself a favour and use the G.U.I.D.E panel
## to edit these.
@export var mappings:Array[GUIDEActionMapping] = []:
	set(value):
		if value == mappings:
			return
		mappings = value
		emit_changed()

## Returns a consolidated list of the display categories of all actions in this context.
func get_display_categories() -> Array[String]:
	var result:GUIDESet = GUIDESet.new()
	for mapping in mappings:
		result.add(mapping.action.display_category)
		
	return result.values()
	
	
## Gets the list of remappable actions for the this context and display category.
func get_remappable_actions(display_category:String) -> Array[GUIDEAction]:
	var result:GUIDESet = GUIDESet.new()
	for mapping in mappings:
		var action:GUIDEAction = mapping.action
		if action.is_remappable and action.display_category == display_category:
			result.add(action)

	return result.values()	


func _editor_name() -> String:
	if display_name.is_empty():
		return resource_path.get_file()
	else:
		return display_name
