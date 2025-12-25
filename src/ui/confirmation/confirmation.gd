@tool
extends UiPage

signal selected(confirmed: bool)

enum Selected { NONE, CANCELED, CONFIRMED }

@export var cancel_button_text: String = "Cancel":
	set(v):
		cancel_button_text = v
		cd.cancel_button_text = cancel_button_text
@export var ok_button_text: String = "OK":
	set(v):
		ok_button_text = v
		cd.ok_button_text = ok_button_text
@export_multiline var dialog_text: String:
	set(v):
		dialog_text = v
		cd.dialog_text = dialog_text

var selection: Selected:
	set(v):
		if selection != v:
			selection = v
			if selection != Selected.NONE:
				var confirmed: bool = true if selection == Selected.CONFIRMED else false
				selected.emit(confirmed)

@onready var cd: ConfirmationDialog = $ConfirmationDialog


func show_ui() -> void:
	cd.visible = true
	super()


func hide_ui() -> void:
	cd.visible = false
	super()


func show_popup_dialog(message: String, _cancel_button_text: String = "Cancel", _ok_button_text: String = "OK") -> bool:
	dialog_text = message
	cancel_button_text = _cancel_button_text
	ok_button_text = _ok_button_text
	selection = Selected.NONE
	show_ui()
	await selected
	hide_ui()
	return true if selection == Selected.CONFIRMED else false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cd.visible = false
	cd.get_label().vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	cd.get_label().horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	cd.canceled.connect(_on_dialog_canceled)
	cd.confirmed.connect(_on_dialog_confirmed)


func _on_dialog_canceled() -> void:
	selection = Selected.CANCELED
	print("User canceled")


func _on_dialog_confirmed() -> void:
	selection = Selected.CONFIRMED
	print("User confirmed")
