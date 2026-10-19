@tool
extends UiPage


func show_ui() -> void:
	UI.pause_move_to_front()
	visible = true


func _ready() -> void:
	call_deferred("_connect_buttons")


func _connect_buttons() -> void:
	if UI:
		%Resume.pressed.connect(_resume)
		%Settings.pressed.connect(UI.go_to.bind("Settings"))
		%Controls.pressed.connect(UI.go_to.bind("Controls"))
		%Quit.pressed.connect(_main_menu)


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_back"):
		get_viewport().set_input_as_handled()
		_resume()


func _resume() -> void:
	if UI:
		UI.go_to("Game")
	get_tree().paused = false


func _main_menu() -> void:
	var result: bool = await UI.show_popup_dialog("Quit to main menu?")
	if not result:
		return
	get_tree().set_deferred("paused", false)
	get_tree().change_scene_to_file("res://src/main.tscn")
