class_name Message
extends Control

# TODO: convert to resource for inspector customization
enum ICON { NONE, SUCCESS, FAILURE }

const MAX_WIDTH: int = 400
const MAX_HEIGHT: int = 90

@export_color_no_alpha var message_color: Color = Color("DFDFDF")
@export_color_no_alpha var border_color: Color = Color("FA6149")
# Panel container color controlled by the ui theme

# Same order as ICON enum
var icon_files: Array = [
	null,
	# use for large res
	#load("res://ui/assets/icons/notifications/checkmark-circle-outline-white.png"),
	#load("res://ui/assets/icons/notifications/cross-circle-outline-white.png"),
	# use for pixel game
	load("res://ui/assets/icons/notifications/pixel-checkmark.png"),
	load("res://ui/assets/icons/notifications/pixel-cross.png")
]

@onready var icon_node: TextureRect = %Icon
@onready var text_node: Label = %Text


func display(text: String, _icon: ICON = ICON.NONE) -> void:
	#icon_node.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	#icon_node.texture = icon_files[icon]
	#icon_node.modulate = message_color
	text_node.text = text
	text_node.modulate = message_color

	scale = Vector2.ZERO
	visible = true

	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_EXPO).set_ease(
		Tween.EASE_IN_OUT
	)
	tween.tween_property(self, "scale", Vector2.ONE, 0.4)
	await get_tree().create_timer(2.0).timeout
	tween = (
		get_tree()
		. create_tween()
		. set_trans(Tween.TRANS_EXPO)
		. set_ease(Tween.EASE_IN_OUT)
		. set_parallel(true)
	)
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
