extends Node

# TODO: Change or remove UI sound effects in code here, or in the scene with the inspector
@export var sfx_button_click: AudioStream = preload("res://src/ui/assets/audio/click1.ogg"):
	set(v):
		sfx_button_click = v
		$UiSfxButtonPressed.set_stream(sfx_button_click)

@export var sfx_button_hover: AudioStream = preload("res://src/ui/assets/audio/rollover5.ogg"):
	set(v):
		sfx_button_hover = v
		$UiSfxButtonHover.set_stream(sfx_button_hover)


func _ready() -> void:
	$UiSfxButtonPressed.set_stream(sfx_button_click)
	$UiSfxButtonHover.set_stream(sfx_button_hover)
	_connect_ui_sfx.call_deferred()
	
	
func _connect_ui_sfx() -> void:
	for sibling: Node in get_parent().get_children():
		if sibling is UiPage:
			# sub to button pressed for sfx
			for button: Node in sibling.find_children("*"):
				if button is Button:
					prints("connecting", sibling.name, button.name, "sfx")
					button.pressed.connect($UiSfxButtonPressed.play)
					button.mouse_entered.connect($UiSfxButtonHover.play)
