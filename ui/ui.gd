extends CanvasLayer


# TODO: consider using the hide_ui and show_ui functions to add ui animation
func hide_ui(page: Variant = null) -> void:
	if page:
		var ui_page: UiPage = _resolve_ui_page(page)
		if ui_page:
			ui_page.hide()
	else:
		for child: Node in get_children():
			if child is UiPage:
				child.hide()


func show_ui(page: Variant) -> void:
	var ui_page: UiPage = _resolve_ui_page(page)
	if ui_page:
		ui_page.show()
		# Uncomment to capture screenshots in media/ folder
		# Must wait for visibility changes and one frame is not enough
		#await get_tree().create_timer(0.2).timeout
		#var cap := get_viewport().get_texture().get_image()
		#cap.save_png("media/%s.png" % ui_page.name)


func go_to(page: Variant) -> void:
	hide_ui()
	show_ui(page)


func is_shown(page: Variant) -> bool:
	var ui_page: CanvasItem = _resolve_ui_page(page)
	if ui_page:
		return ui_page.visible
	return false


func _resolve_ui_page(node_or_name: Variant) -> Node:
	if node_or_name is UiPage:
		return node_or_name
	if node_or_name is String:
		var node: Node = find_child(node_or_name)
		if node is UiPage:
			return node
	push_error("Can't find ui page ", node_or_name)
	return


func _ready() -> void:
	hide()
	for child: Node in get_children():
		if child is UiPage:
			child.set("ui", self)
			child.hide()
	show()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_controls"):
		# If we have a focus control, clear it
		if get_viewport().gui_get_focus_owner():
			get_viewport().gui_get_focus_owner().release_focus()
		else:
			_focus_something()
		get_viewport().set_input_as_handled()
		return

	if (
		not get_viewport().gui_get_focus_owner() is Control
		and (event is InputEventJoypadMotion or event is InputEventJoypadButton)
	):
		for child: Node in get_children():
			if not child is UiPage or not child.visible:
				continue
			child = child as UiPage
			if not child.prevent_joypad_focus_capture:
				_focus_something()
				get_viewport().set_input_as_handled()
				break


func _focus_something() -> void:
	for child: Node in get_children():
		if not child is UiPage or not child.visible:
			continue
		# use default focus control if defined
		child = child as UiPage
		if child.default_focus_control:
			child.default_focus_control.grab_focus()
			return
		# grab_focus on first button found
		for button: Button in child.find_children("*", "Button"):
			# Helpful for discovering focus going to a button hidden by a parent
			#print("Focus something found button %s" % button.name)
			if button.visible:
				button.grab_focus()
				break
