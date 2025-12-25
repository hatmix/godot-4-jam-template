extends Node

## Use UI/MessageBox to display a status update message to the player
@warning_ignore("unused_signal")
signal post_ui_message(text: String)

## Emitted by UI/Controls when a action is remapped
@warning_ignore("unused_signal")
signal controls_changed(config: GUIDERemappingConfig)

## Set true to force display of virtual joysticks ui page for debug/development
var show_virtual_controls: bool = false

var game: Game:
	get():
		if not is_instance_valid(game):
			game = get_tree().get_first_node_in_group("__Game__")
		return game

var ui: UI:
	get():
		if not is_instance_valid(ui):
			ui = get_tree().get_first_node_in_group("__UI__")
		return ui
