extends Control

var ui: Node

# TODO: Replace game_ui.tscn and game_ui.gd with your game's UI/HUD

func _input(_event: InputEvent) -> void:
	if visible and Input.is_action_just_pressed("ui_cancel"):
		accept_event()
		get_tree().paused = true
		ui.go_to("PauseMenu")
