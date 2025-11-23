@icon("ui-page-icon.svg")
class_name UiPage
extends Control

# Base control for grouping UI elements to show & hide together

@export var prevent_joypad_focus_capture: bool = false
@export var default_focus_control: Control

var ui: UI


func _enter_tree() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	process_mode = Node.PROCESS_MODE_ALWAYS
	

# TODO: consider using the hide_ui and show_ui to add ui animation
# The commented example here adds a scaling pop in effect to every UiPage
# Each UiPage can provide its own animation by extending the script and 
# overiding the methods (Note that template UiPages already have extended
# scripts attached)
# When overriding hide_ui ensure visible=false at end (contract)
func hide_ui() -> void:
	#var tween: Tween = create_tween()
	#tween.tween_property(self, "scale", Vector2.ZERO, 0.15).set_trans(Tween.TRANS_SINE)
	#await tween.finished
	visible = false
	
# When overriding show_ui ensure visible=true at end (contract)
func show_ui() -> void:
	visible = true
	#var tween: Tween = create_tween()
	#tween.tween_property(self, "scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_SINE)
	#await tween.finished


# preset_ui should implement hide_ui without animation time
func preset_ui() -> void:
	#pivot_offset = size / 2
	#scale = Vector2.ZERO
	visible = false


# Convenience function for page "back" buttons to return either to main_menu or pause_menu
func go_back() -> void:
	if get_tree().paused == true:
		ui.go_to("PauseMenu")
	else:
		ui.go_to("MainMenu")
