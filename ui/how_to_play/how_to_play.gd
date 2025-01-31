extends UiPage


func _ready() -> void:
	%MarkdownLabel.display_file("res://HOW_TO_PLAY.md")
	call_deferred("_connect_buttons")


func _connect_buttons() -> void:
	if ui:
		%Back.pressed.connect(ui.go_to.bind("MainMenu"))


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_back"):
		get_viewport().set_input_as_handled()
		go_back()
