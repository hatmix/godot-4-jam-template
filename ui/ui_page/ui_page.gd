class_name UiPage
extends Control

# Base control for grouping UI elements to show & hide together

@export var prevent_joypad_focus_capture: bool = false
@export var default_focus_control: Control

var ui: CanvasLayer


# Convenience function for page "back" buttons to return either to main_menu or pause_menu
func go_back() -> void:
	if get_tree().paused == true:
		ui.go_to("PauseMenu")
	else:
		ui.go_to("MainMenu")
