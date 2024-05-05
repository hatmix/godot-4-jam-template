extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready():
    %Resume.pressed.connect(func(): GuiTransitions.go_to("Game"))
    %Settings.pressed.connect(func(): GuiTransitions.go_to("Settings"))
    %Quit.pressed.connect(func(): GuiTransitions.go_to("MainMenu"))


func _input(_event):
    # $GuiTransition._status is non-zero while transition is active
    if visible and not $GuiTransition._status and Input.is_action_just_pressed("ui_cancel"):
        get_viewport().set_input_as_handled()
        GuiTransitions.go_to("Game")
