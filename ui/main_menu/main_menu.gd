extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Play.pressed.connect(GuiTransitions.go_to.bind("Game"))
	%Settings.pressed.connect(GuiTransitions.go_to.bind("Settings"))
	%Credits.pressed.connect(GuiTransitions.go_to.bind("Credits"))
	%Exit.pressed.connect(get_tree().call_deferred.bind("quit"))
