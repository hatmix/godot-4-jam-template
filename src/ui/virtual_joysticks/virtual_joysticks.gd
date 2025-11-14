extends UiPage

@onready var label: Label = $Label

# TODO: actions & mapping context?
func _ready() -> void:
	
	if OS.has_feature("web_android") or OS.has_feature("web_ios") or \
		(Globals.show_virtual_controls and OS.has_feature("debug")):
		show_ui.call_deferred()
	else:
		queue_free()


func show_ui() -> void:
	if not ui.is_preset_ready:
		await ui.preset_ready
	label.text = "resolution: %v" % get_viewport_rect().size
	move_to_front()
	visible = true
