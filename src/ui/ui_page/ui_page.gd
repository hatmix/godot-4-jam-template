@tool
@icon("ui-page-icon.svg")
class_name UiPage
extends MarginContainer
# Base control for grouping UI elements to show & hide together

## Wheter ui_fx will apply to controls on this UiPage
@export var connect_fx: bool = true
@export var prevent_joypad_focus_capture: bool = false
@export var default_focus_control: Control

@export var ui_margin_left: int = 0:
	set(v):
		ui_margin_left = v
		update_margins()
@export var ui_margin_top: int = 0:
	set(v):
		ui_margin_top = v
		update_margins()
@export var ui_margin_right: int = 0:
	set(v):
		ui_margin_right = v
		update_margins()
@export var ui_margin_bottom: int = 0:
	set(v):
		ui_margin_bottom = v
		update_margins()

var ui: UI

@onready var content_margin_container: MarginContainer = %ContentMarginContainer


# Using enter tree so extended scripts don't need to call super() in ready
func _enter_tree() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	process_mode = Node.PROCESS_MODE_ALWAYS
	_hook_ui_scale_changed.call_deferred()
	update_margins.call_deferred()


# TODO: consider using the hide_ui and show_ui to add ui animation
# The commented example here adds a scaling pop in effect to every UiPage
# Each UiPage can provide its own animation by extending the script and
# overiding the methods (Note that template UiPages already have extended
# scripts attached)
# When overriding hide_ui ensure visible=false at end (contract)
func hide_ui() -> void:
	#pivot_offset = size / 2
	#var tween: Tween = create_tween()
	#tween.tween_property(self, "scale", Vector2.ZERO, 0.2).set_trans(Tween.TRANS_SINE)
	#await tween.finished
	visible = false


# When overriding show_ui ensure visible=true at end (contract)
func show_ui() -> void:
	#pivot_offset = size / 2
	#scale = Vector2.ZERO
	visible = true
	#var tween: Tween = create_tween()
	#tween.tween_property(self, "scale", Vector2.ONE, 0.2).set_trans(Tween.TRANS_SINE)
	#await tween.finished


# preset_ui should implement hide_ui without animation time
func preset_ui() -> void:
	#pivot_offset = size / 2
	#scale = Vector2.ZERO
	visible = false


# If the node %ContentMarginContainer is present in the UiPage, its margins will
# be set to the exported value
func update_margins() -> void:
	if is_instance_valid(content_margin_container):
		content_margin_container.add_theme_constant_override("margin_left", ui_margin_left)
		content_margin_container.add_theme_constant_override("margin_top", ui_margin_top)
		content_margin_container.add_theme_constant_override("margin_right", ui_margin_right)
		content_margin_container.add_theme_constant_override("margin_bottom", ui_margin_bottom)


# Convenience function for page "back" buttons to return either to main_menu or pause_menu
func go_back() -> void:
	if get_tree().paused == true:
		hide_ui()
		ui.show_ui("PauseMenu")
	else:
		ui.go_to("MainMenu")


func _hook_ui_scale_changed() -> void:
	if is_instance_valid(ui):
		ui.scale_changed.connect(_on_ui_scale_changed)


func _on_ui_scale_changed() -> void:
	add_theme_constant_override("margin_top", int(-ui.offset.y / ui.scale.y))
	add_theme_constant_override("margin_left", int(-ui.offset.x / ui.scale.x))
	add_theme_constant_override("margin_bottom", int(-ui.offset.y / ui.scale.y))
	add_theme_constant_override("margin_right", int(-ui.offset.x / ui.scale.x))
