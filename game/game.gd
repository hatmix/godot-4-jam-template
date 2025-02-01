extends Node2D

@export var default_mapping_context: GUIDEMappingContext


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GUIDE.enable_mapping_context(default_mapping_context)
	#await get_tree().process_frame
	$UI.show_ui("Game")
