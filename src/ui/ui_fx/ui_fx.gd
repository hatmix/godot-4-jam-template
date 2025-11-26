extends Node

# TODO: Change or remove UI sound effects in code here, or in the scene with the inspector
@export var sfx_button_click: AudioStream = preload("res://src/ui/assets/audio/click1.ogg"):
	set(v):
		sfx_button_click = v
		$UiSfxButtonPressed.set_stream(sfx_button_click)

@export var sfx_button_focused: AudioStream = preload("res://src/ui/assets/audio/rollover5.ogg"):
	set(v):
		sfx_button_focused = v
		$UiSfxButtonFocused.set_stream(sfx_button_focused)

@export var sfx_slider_focused: AudioStream = preload("res://src/ui/assets/audio/rollover5.ogg"):
	set(v):
		sfx_slider_focused = v
		$UiSfxSliderFocused.set_stream(sfx_slider_focused)

var tween_lookup: Dictionary[Node, Tween] = {}


func get_node_tween(node: Node) -> Tween:
	if node in tween_lookup:
		tween_lookup[node].kill()
	tween_lookup[node] = create_tween().bind_node(node)
	return tween_lookup[node]


func _ready() -> void:
	$UiSfxButtonPressed.set_stream(sfx_button_click)
	$UiSfxButtonFocused.set_stream(sfx_button_focused)
	$UiSfxSliderFocused.set_stream(sfx_button_focused)
	_connect_ui_fx.call_deferred()


func _connect_ui_fx() -> void:
	for sibling: Node in get_parent().get_children():
		if sibling is UiPage and sibling.connect_fx:
			for node: Node in sibling.find_children("*"):
				if node is Button:
					prints("connecting", sibling.name, node.name, "sfx")
					node.pressed.connect(_on_button_pressed.bind(node))
					node.mouse_entered.connect(_on_button_focus_entered.bind(node))
					node.mouse_exited.connect(_on_button_focus_exited.bind(node))
					node.focus_entered.connect(_on_button_focus_entered.bind(node))
					node.focus_exited.connect(_on_button_focus_exited.bind(node))
				if node is Slider:
					node.mouse_entered.connect(_on_slider_focus_entered.bind(node))
					node.mouse_exited.connect(_on_slider_focus_exited.bind(node))
					node.focus_entered.connect(_on_slider_focus_entered.bind(node))
					node.focus_exited.connect(_on_slider_focus_exited.bind(node))


#region Button FX
func _on_button_pressed(_control: Button) -> void:
	$UiSfxButtonPressed.play()


func _on_button_focus_entered(control: Button) -> void:
	$UiSfxButtonFocused.play()
	var tween: Tween = get_node_tween(control)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(control, "z_index", control.z_index + 1, 0)
	if control.get_parent() is HBoxContainer:
		tween.tween_property(control, "position:y", -20, 0.2)
	else:
		tween.tween_property(control, "position:x", 20, 0.2)


func _on_button_focus_exited(control: Button) -> void:
	var tween: Tween = get_node_tween(control)
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(control, "z_index", control.z_index - 1, 0)
	if control.get_parent() is HBoxContainer:
		tween.tween_property(control, "position:y", 0, 0.2)
	else:
		tween.tween_property(control, "position:x", 0, 0.2)


#endregion


#region Slider
func _on_slider_focus_entered(_control: Slider) -> void:
	$UiSfxSliderFocused.play()


func _on_slider_focus_exited(_control: Slider) -> void:
	pass
#endregion
