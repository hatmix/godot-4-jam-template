extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Resume.pressed.connect(_resume)
	%Settings.pressed.connect(GuiTransitions.go_to.bind("Settings"))
	%Quit.pressed.connect(_main_menu)


func _input(_event: InputEvent) -> void:
	# $GuiTransition._status is non-zero while transition is active
	if visible and not %GuiTransition._status and Input.is_action_just_pressed("ui_cancel"):
		accept_event()
		_resume()


func _resume() -> void:
	GuiTransitions.go_to("Game")
	await GuiTransitions.hide_completed
	get_tree().paused = false


func _main_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")
