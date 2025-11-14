extends UiPage

# TODO: Create your game's UI/HUD beginning here

# Note for aligning control in UI canvas layer to node in world:
# ui.control.global_position = get_tree().current_scene.get_canvas_transform() * node.global_position

var pushed_state: bool = false


func show_ui() -> void:
	if pushed_state:
		pushed_state = false
		ui.pop_state()
	
	# put this here so it shows in "game ui" and not "main menu"
	if is_instance_valid(ui) and ui.browser_on_mobile:
		ui.show_ui("VirtualJoysticks")



func _ready() -> void:
	%ToggleGuideDebugger.toggled.connect(_toggle_guide_debugger)
	%GuideDebugger.hide()


func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		accept_event()
		get_tree().paused = true
		ui.push_state()
		pushed_state = true
		ui.go_to("PauseMenu")


func _toggle_guide_debugger(toggled_on: bool) -> void:
	%GuideDebugger.visible = toggled_on
	%ToggleGuideDebugger.release_focus()
	await get_tree().process_frame
	%ToggleGuideDebugger.release_focus()
