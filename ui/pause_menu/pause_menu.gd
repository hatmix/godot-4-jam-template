extends Control

var ui: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("_connect_buttons")


func _connect_buttons() -> void:
	if ui:
		%Resume.pressed.connect(_resume)
		%Settings.pressed.connect(ui.go_to.bind("Settings"))
		%Controls.pressed.connect(ui.go_to.bind("Controls"))
		%Quit.pressed.connect(_main_menu)


func _input(_event: InputEvent) -> void:
	if visible and Input.is_action_just_pressed("ui_cancel"):
		accept_event()
		_resume()
	if ui:
		ui._input(_event)


func _resume() -> void:
	if ui:
		ui.go_to("Game")
	get_tree().paused = false


func _main_menu() -> void:
	get_tree().set_deferred("paused", false)
	get_tree().change_scene_to_file("res://main.tscn")
