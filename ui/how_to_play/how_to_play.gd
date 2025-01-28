extends Control

var ui: Node


func _ready() -> void:
	%MarkdownLabel.display_file("res://HOW_TO_PLAY.md")
	call_deferred("_connect_buttons")


func _connect_buttons() -> void:
	if ui:
		%Back.pressed.connect(ui.go_to.bind("MainMenu"))


func _input(_event: InputEvent) -> void:
	if visible and Input.is_action_just_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		ui.go_to("MainMenu")
