extends Control

var pointer_icon: Texture2D = load("res://ui/assets/icons/finger-point-right.png")

func _ready() -> void:
	%Play.pressed.connect(GuiTransitions.go_to.bind("Game"))
	%Settings.pressed.connect(GuiTransitions.go_to.bind("Settings"))
	%Controls.pressed.connect(GuiTransitions.go_to.bind("Controls"))
	%Credits.pressed.connect(GuiTransitions.go_to.bind("Credits"))
	%Exit.pressed.connect(get_tree().call_deferred.bind("quit"))
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

	if OS.get_name() == "Web":
		%Exit.hide()

func _on_focus_changed(control: Control) -> void:
	if not visible:
		return
	for button: Button in %Buttons.get_children():
		if button == control:
			button.icon = pointer_icon
		else:
			button.icon = null
