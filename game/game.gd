extends Node2D
# This scene is started by clicking the "Play" button in main.tscn.
# Change Project Settings: application/run/start_scene to game/game.tscn to skip the menus while developing

# TODO: Create your game beginning here


func _ready() -> void:
	$UI.show_ui("Game")
