@tool
extends UiPage

var _roll: bool = false
var scroll_amt: float = 0


func _ready() -> void:
	%MarkdownLabel.display_file("res://ATTRIBUTION.md")
	call_deferred("_connect_buttons")
	%Spacer.custom_minimum_size.y = get_viewport_rect().size.y
	%Thanks.custom_minimum_size.y = get_viewport_rect().size.y
	%Spacer.visible = false
	%Thanks.visible = false
	# Change to this scene from game to roll credits, and easier testing
	if get_tree().current_scene == self:
		roll_credits()


func _connect_buttons() -> void:
	if not Engine.is_editor_hint():
		%Back.pressed.connect(_back)


func _back() -> void:
	if get_tree().current_scene == self:
		get_tree().change_scene_to_file("res://src/main.tscn")
		return
	go_back()


func _input(event: InputEvent) -> void:
	if Engine.is_editor_hint() or not visible:
		return
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_back"):
		get_viewport().set_input_as_handled()
		go_back()


func _process(delta: float) -> void:
	if not _roll:
		return
	scroll_amt += delta * 50
	%ScrollContainer.scroll_vertical = round(scroll_amt)
	if %ScrollContainer.scroll_vertical < round(scroll_amt):
		_roll = false
		%Back.visible = true


func roll_credits() -> void:
	print("roll credits")
	%Spacer.visible = true
	%Thanks.visible = true
	%Back.visible = false
	visible = true
	await get_tree().process_frame
	_roll = true
	
