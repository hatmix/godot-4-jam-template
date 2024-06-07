class_name MessageQueue
extends Control

var message_scene: PackedScene = preload("res://ui/notifications/message.tscn")


func _ready() -> void:
	$Timer.timeout.connect(_check_queue)
	SignalBus.post_message.connect(post_message)


func _check_queue() -> void:
	if %Messages.get_child_count() == 0:
		GuiTransitions.hide("MessageQueue")


func post_message(text: String, icon: Message.ICON = Message.ICON.NONE) -> void:
	if not GuiTransitions.is_shown("MessageQueue"):
		GuiTransitions.show("MessageQueue")
	var message: Message = message_scene.instantiate()
	%Messages.add_child(message)
	message.display(text, icon)
