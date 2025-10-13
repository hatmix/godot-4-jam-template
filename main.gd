extends Node

@export var default_mapping_context: GUIDEMappingContext


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GUIDE.enable_mapping_context(default_mapping_context)
	show_main_menu.call_deferred()


func show_main_menu() -> void:
	if not $UI.is_preset_ready:
		await $UI.preset_ready
	$UI.show_ui("MainMenu")
