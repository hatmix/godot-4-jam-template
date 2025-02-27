# See https://github.com/godotneers/G.U.I.D.E/blob/main/guide_examples/shared/instructions_label.gd
class_name InputPrompt
extends RichTextLabel

@export_multiline var prompt_text: String
@export var actions: Array[GUIDEAction] = []
@export var icon_size: int:
	set(value):
		icon_size = value
		_formatter = GUIDEInputFormatter.for_active_contexts(icon_size)

var _formatter: GUIDEInputFormatter = GUIDEInputFormatter.for_active_contexts()


static func create(
	_prompt_text: String, _actions: Array[GUIDEAction], _icon_size: int = 24
) -> InputPrompt:
	var prompt = InputPrompt.new()
	prompt.prompt_text = _prompt_text
	prompt.actions = _actions
	prompt.icon_size = _icon_size
	return prompt


func _ready() -> void:
	bbcode_enabled = true
	fit_content = true
	scroll_active = false
	autowrap_mode = TextServer.AUTOWRAP_OFF

	GUIDE.input_mappings_changed.connect(_update_label)
	call_deferred("_update_label")


func _update_label() -> void:
	if GUIDE.get_enabled_mapping_contexts().is_empty():
		visible = false
		return

	var replacements: Array[String] = []
	for action: GUIDEAction in actions:
		replacements.append(await _formatter.action_as_richtext_async(action))

	parse_bbcode(prompt_text % replacements)
