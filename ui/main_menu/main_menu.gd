extends Control


func _ready() -> void:
	%Play.pressed.connect(GuiTransitions.go_to.bind("Game"))
	%Settings.pressed.connect(GuiTransitions.go_to.bind("Settings"))
	%Credits.pressed.connect(GuiTransitions.go_to.bind("Credits"))
	%Exit.pressed.connect(get_tree().call_deferred.bind("quit"))

	if OS.get_name() == "Web":
		%Exit.hide()
