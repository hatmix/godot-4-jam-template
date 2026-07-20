@tool
extends PanelContainer


var text : String : set = set_text
var disabled : bool
var index : int

@onready var line_edit := %LineEdit as LineEdit
@onready var remove_button := %RemoveButton as Button
@onready var case_checkbox := %CaseSensativeCheckbox as CheckBox
@onready var colour_picker := %ColorPickerButton as ColorPickerButton

func _ready() -> void:
	line_edit.text = text
	remove_button.disabled = disabled
	if (Engine.is_editor_hint()):
		remove_button.icon = EditorInterface.get_base_control().get_theme_icon("GuiClose", "EditorIcons")


func set_text(value: String) -> void:
	text = value
	if line_edit:
		line_edit.text = value
