extends Control


func _ready():
    pass # Replace with function body.


func _input(_event):
    # $GuiTransition._status is non-zero while transition is active
    if visible and not $GuiTransition._status and Input.is_action_just_pressed("ui_cancel"):
        get_viewport().set_input_as_handled()
        GuiTransitions.go_to("PauseMenu")


