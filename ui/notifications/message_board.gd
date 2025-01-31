class_name MessageQueue
extends UiPage

var message_scene: PackedScene = preload("res://ui/notifications/message.tscn")


func _ready() -> void:
	$Timer.timeout.connect(_check_queue)
	Globals.post_ui_message.connect(show_message)


func _check_queue() -> void:
	if %Messages.get_child_count() == 0:
		ui.hide_ui("MessageBoard")


func show_message(text: String) -> void:
	if not ui.is_shown("MessageBoard"):
		ui.show_ui("MessageBoard")
	var message: Message = message_scene.instantiate()
	%Messages.add_child(message)
	message.display(text)
