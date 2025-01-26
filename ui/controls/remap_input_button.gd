extends CenterContainer

# Injected
var remapper: GUIDERemapper
var formatter: GUIDEInputFormatter
var item: GUIDERemapper.ConfigItem:
	set(value):
		item = value
		if not is_inside_tree():
			await ready
		if not item.changed.is_connected(_build_label):
			_build_label(remapper.get_bound_input_or_null(item))
			item.changed.connect(_build_label)

# Example input_text value:
#[img]user://_guide_cache/5514223b7be916319ab4de00586a8b9adf0a96ba957b9ee1ebcb3a30d0a5dc02.res[/img]

#@onready var button: Button = $RichTextLabel/MarginContainer/Button
@onready var button: Button = $RichTextLabel/Button
@onready var _label: RichTextLabel = $RichTextLabel


func _ready() -> void:
	_label.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _build_label(input: GUIDEInput) -> void:
	var input_text: String = await formatter.input_as_richtext_async(input)
	_label.parse_bbcode("[center]%s[/center]" % input_text)
