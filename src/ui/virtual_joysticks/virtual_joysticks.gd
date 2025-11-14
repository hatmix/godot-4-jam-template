extends UiPage


# TODO: actions & mapping context?
func _ready() -> void:
	
	if OS.has_feature("web_android") or OS.has_feature("web_ios") or \
		(Globals.show_virtual_controls and OS.has_feature("debug")):
		show_ui.call_deferred()
	else:
		queue_free()


func show_ui() -> void:
	await ui.preset_ready
	move_to_front()
	visible = true
