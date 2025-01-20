extends Control

var pointer_icon: Texture2D = load("res://ui/assets/icons/finger-point-right.png")
var ui: Node


func _ready() -> void:
	call_deferred("_connect_buttons")
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

	if OS.get_name() == "Web":
		%Exit.hide()


func _connect_buttons() -> void:
	%Play.pressed.connect(ui.go_to.bind("Game"))
	%HowToPlay.pressed.connect(ui.go_to.bind("HowToPlay"))
	%Settings.pressed.connect(ui.go_to.bind("Settings"))
	%Controls.pressed.connect(ui.go_to.bind("Controls"))
	%Credits.pressed.connect(ui.go_to.bind("Credits"))
	%Exit.pressed.connect(get_tree().call_deferred.bind("quit"))


func _on_focus_changed(control: Control) -> void:
	if not visible:
		return
	for button: Button in %Buttons.get_children():
		if button == control:
			button.icon = pointer_icon
		else:
			button.icon = null
