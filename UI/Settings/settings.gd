extends CenterContainer


var _previous_layout = "MainMenu"


func _ready():
    %Back.pressed.connect(_on_back)


func _input(_event):
    # $GuiTransition._status is non-zero while transition is active
    if visible and not $GuiTransition._status and Input.is_action_just_pressed("ui_cancel"):
        get_viewport().set_input_as_handled()
        GuiTransitions.go_to(_previous_layout)


func _on_back():
    # TODO: add test for coming from pause menu or main menu, maybe if game active
    GuiTransitions.go_to(_previous_layout)
