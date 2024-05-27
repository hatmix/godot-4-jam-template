extends CanvasLayer


func _ready() -> void:
	GuiTransitions.show_completed.connect(_on_show_completed)
	GuiTransitions.hide()
	call_deferred("show_main_menu")


func show_main_menu() -> void:
	GuiTransitions.go_to("MainMenu")


func _on_show_completed() -> void:
	# If nothing focused, automatically grab_focus on first button in layout
	if get_viewport().gui_get_focus_owner() == null:
		for layout_name: String in GuiTransitions._layouts.keys():
			for layout_transition: GuiTransition in GuiTransitions._layouts[layout_name]:
				var layout: Node = layout_transition.get_node(layout_transition.layout)
				if layout.visible:
					for button: Button in layout.find_children("*", "Button"):
						button.grab_focus()
						break
					break
