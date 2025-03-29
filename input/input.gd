extends Node2D

@export var default_mapping_context: GUIDEMappingContext


func _ready() -> void:
	GUIDE.enable_mapping_context(default_mapping_context)
