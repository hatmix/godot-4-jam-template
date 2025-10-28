@icon("ui-page-icon.svg")
class_name UiPage
extends Control

# Base control for grouping UI elements to show & hide together

@export var prevent_joypad_focus_capture: bool = false
@export var default_focus_control: Control

var ui: CanvasLayer


func preset_ui() -> void:
	pivot_offset = size / 2
	#scale = Vector2.ZERO
	visible = false


func hide_ui() -> void:
	#var tween: Tween = create_tween()
	#tween.tween_property(self, "position:x", -640, 0.2)
	#tween.tween_property(self, "scale", Vector2.ZERO, 0.15).set_trans(Tween.TRANS_SINE)
	#await tween.finished
	visible = false
	
	
func show_ui() -> void:
	visible = true
	#var tween: Tween = create_tween()
	#tween.tween_property(self, "position:x", 0, 0.2)
	#tween.tween_property(self, "scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_SINE)
	#await tween.finished


# Convenience function for page "back" buttons to return either to main_menu or pause_menu
func go_back() -> void:
	if get_tree().paused == true:
		ui.go_to("PauseMenu")
	else:
		ui.go_to("MainMenu")
