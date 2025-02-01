extends Node2D
# This scene is started by clicking the "Play" button in main.tscn.
# Change Project Settings: application/run/start_scene to game/game.tscn to skip the menus while developing

@export var default_mapping_context: GUIDEMappingContext

# TODO: Create your game beginning here


func _ready() -> void:
	GUIDE.enable_mapping_context(default_mapping_context)
	$UI.show_ui("Game")
