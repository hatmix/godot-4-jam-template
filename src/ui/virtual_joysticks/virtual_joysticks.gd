extends UiPage

var should_show: bool = false

@onready var label: Label = $Label


func _ready() -> void:
	# Display when browser on mobile detected
	if OS.has_feature("web_android") or OS.has_feature("web_ios") or \
		(Globals.show_virtual_controls and OS.has_feature("debug")):
			should_show = true


func show_ui() -> void:
	if is_instance_valid(ui):
		if not ui.is_preset_ready:
			await ui.preset_ready
	label.text = "resolution: %0.1v" % get_viewport_rect().size
	move_to_front()
	visible = true


func _process(_delta: float) -> void:
	if should_show:
		show_ui()
