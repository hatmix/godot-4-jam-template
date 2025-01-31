extends Control

var ui: Node
# We don't want joypad input to focus a button in the game ui
var prevent_joypad_focus_capture: bool = true

# TODO: Replace game_ui.tscn and game_ui.gd with your game's UI/HUD


func _ready() -> void:
	%ToggleGuideDebugger.pressed.connect(_toggle_guide_debugger)
	%GuideDebugger.hide()


func _input(_event: InputEvent) -> void:
	if visible and Input.is_action_just_pressed("ui_cancel"):
		accept_event()
		get_tree().paused = true
		ui.go_to("PauseMenu")


func _toggle_guide_debugger() -> void:
	%GuideDebugger.visible = !%GuideDebugger.visible
	%ToggleGuideDebugger.release_focus()
