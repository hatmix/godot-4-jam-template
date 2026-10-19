@tool
class_name MessageQueue
extends UiPage

var message_scene: PackedScene = preload("message.tscn")


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	$Timer.timeout.connect(_check_queue)


func _check_queue() -> void:
	if %Messages.get_child_count() == 0:
		UI.hide_ui("MessageBoard")


func show_message(text: String) -> void:
	if not UI.is_shown("MessageBoard"):
		UI.show_ui("MessageBoard")
	var message: Message = message_scene.instantiate()
	%Messages.add_child(message)
	message.display(text)
