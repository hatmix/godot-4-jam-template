extends CanvasLayer


# TODO: consider using the hide_ui and show_ui functions to add ui animation
func hide_ui(page: Variant = null) -> void:
	if page:
		var ui_page: CanvasItem = _resolve_ui_page(page)
		if ui_page:
			ui_page.hide()
	else:
		for child: Node in get_children():
			if child is CanvasItem:
				child.hide()


func show_ui(page: Variant) -> void:
	var ui_page: CanvasItem = _resolve_ui_page(page)
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
	if node_or_name is CanvasItem:
		return node_or_name
	if node_or_name is String:
		var node: Node = find_child(node_or_name)
		if node is CanvasItem:
			return node
	push_error("Can't find ui page ", node_or_name)
	return


func _ready() -> void:
	hide()
	for child: Node in get_children():
		if child is CanvasItem:
			child.set("ui", self)
			child.hide()
	show()


func _input(event: InputEvent) -> void:
	if not get_viewport().gui_get_focus_owner():
		if (
			event is InputEventJoypadMotion
			or event is InputEventJoypadButton
			or event.is_action_pressed("ui_focus_controls")
		):
			_focus_something(event)


func _focus_something(event: InputEvent) -> void:
	# grab_focus on first button found in visible ui pages
	for child: Node in get_children():
		if child is Control and child.visible:
			if (
				_has_prevent_focus_capture(child)
				and not event.is_action_pressed("ui_focus_controls")
			):
				continue
			for button: Button in child.find_children("*", "Button"):
				# Helpful for discovering focus goes to a hidden button
				#print("Focus something found button %s" % button.name)
				button.grab_focus()
				break
				break


func _has_prevent_focus_capture(ui_page: Control) -> bool:
	return "prevent_joypad_focus_capture" in ui_page and ui_page.prevent_joypad_focus_capture
