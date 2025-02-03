extends UiPage

# TODO: Create your game's UI/HUD beginning here


func _ready() -> void:
	%ToggleGuideDebugger.toggled.connect(_toggle_guide_debugger)
	visibility_changed.connect(_on_visibility_changed)
	%GuideDebugger.hide()


func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		accept_event()
		get_tree().paused = true
		ui.go_to("PauseMenu")


func _on_visibility_changed() -> void:
	if visible and ui:
		ui.background.hide()


func _toggle_guide_debugger(toggled_on: bool) -> void:
	%GuideDebugger.visible = toggled_on
	%ToggleGuideDebugger.release_focus()
	await get_tree().process_frame
	%ToggleGuideDebugger.release_focus()
