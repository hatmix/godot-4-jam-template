extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_main_menu.call_deferred()


func show_main_menu() -> void:
	await get_tree().create_timer(0.5).timeout
	$UI.show()
	GuiTransitions.go_to("MainMenu")
	# not sure why this is needed, but go_to tends to fail on its own in this case
	GuiTransitions.show("MainMenu")
