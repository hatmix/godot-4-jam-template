extends Control


func _ready() -> void:
	%Back.pressed.connect(GuiTransitions.go_to.bind("MainMenu"))
	%MarkdownLabel.display_file("res://ATTRIBUTION.md")


func _input(_event: InputEvent) -> void:
	# $GuiTransition._status is non-zero while transition is active
	if visible and not $GuiTransition._status and Input.is_action_just_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		GuiTransitions.go_to("MainMenu")
