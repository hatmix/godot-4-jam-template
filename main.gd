extends Node

@export var default_mapping_context: GUIDEMappingContext


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GUIDE.enable_mapping_context(default_mapping_context)
	show_main_menu.call_deferred()


func show_main_menu() -> void:
	await get_tree().create_timer(0.5).timeout
	$UI.show_ui("MainMenu")
