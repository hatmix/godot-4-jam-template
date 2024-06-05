extends Control


func _input(_event: InputEvent) -> void:
	# $GuiTransition._status is non-zero while transition is active
	if visible and not $GuiTransition._status and Input.is_action_just_pressed("ui_cancel"):
		accept_event()
		get_tree().paused = true
		GuiTransitions.go_to("PauseMenu")
