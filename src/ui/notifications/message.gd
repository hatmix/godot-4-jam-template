class_name Message
extends PanelContainer

const MAX_WIDTH: int = 400
const MAX_HEIGHT: int = 90

@export_color_no_alpha var message_color: Color = Color("DFDFDF")
@export_color_no_alpha var border_color: Color = Color("FA6149")
# Panel container color controlled by the ui theme

@onready var text_node: Label = %Text


func display(text: String) -> void:
	text_node.text = text
	text_node.modulate = message_color

	visible = true

	var tween: Tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_interval(2.0)
	tween.tween_property(self, "modulate", Color(Color.WHITE, 0.0), 1.0)
	await tween.finished
	queue_free()


func _ready() -> void:
	visible = false
	resized.connect(_on_resized)
	text_node.resized.connect(_on_text_resized)


func _on_resized() -> void:
	#print("panel resized ", size)
	pivot_offset = size / 2
	#pivot_offset.y = size.y


func _on_text_resized() -> void:
	#print("text resized ", text_node.size)
	if text_node.size.x > MAX_WIDTH:
		text_node.custom_minimum_size.x = MAX_WIDTH
		text_node.custom_minimum_size.y += 30
		text_node.autowrap_mode = TextServer.AUTOWRAP_WORD
