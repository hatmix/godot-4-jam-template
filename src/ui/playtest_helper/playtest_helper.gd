@tool
extends UiPage


func _ready() -> void:
	%ToggleGuideDebugger.toggled.connect(_toggle_guide_debugger)
	%GuideDebugger.hide()


func _toggle_guide_debugger(toggled_on: bool) -> void:
	%GuideDebugger.visible = toggled_on
	%ToggleGuideDebugger.release_focus()
	await get_tree().process_frame
	%ToggleGuideDebugger.release_focus()
