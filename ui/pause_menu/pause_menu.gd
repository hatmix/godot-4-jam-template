extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Resume.pressed.connect(GuiTransitions.go_to.bind("Game"))
	%Settings.pressed.connect(GuiTransitions.go_to.bind("Settings"))
	%Quit.pressed.connect(GuiTransitions.go_to.bind("MainMenu"))


func _input(_event: InputEvent) -> void:
	# $GuiTransition._status is non-zero while transition is active
	if visible and not $GuiTransition._status and Input.is_action_just_pressed("ui_cancel"):
		accept_event()
		GuiTransitions.go_to("Game")
