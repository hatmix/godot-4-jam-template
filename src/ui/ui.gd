extends CanvasLayer

signal preset_ready

var is_preset_ready: bool = false


# TODO: consider using the hide_ui and show_ui functions to add ui animation
func hide_ui(page: Variant = null) -> void:
	if page:
		var ui_page: UiPage = _resolve_ui_page(page)
		if ui_page and ui_page.visible:
			await ui_page.hide_ui()
	else:
		for child: Node in get_children():
			if child is UiPage and child.visible:
				await child.hide_ui()
				child.hide()


func show_ui(page: Variant) -> void:
	print("show_ui ", page)
	var ui_page: UiPage = _resolve_ui_page(page)
	if ui_page:
		ui_page.show()
		if ui_page.has_method("show_ui"):
			await ui_page.show_ui()
		# Uncomment to capture screenshots in media/ folder
		# Must wait for visibility changes and one frame is not enough
		#await get_tree().create_timer(0.2).timeout
		#var cap := get_viewport().get_texture().get_image()
		#cap.save_png("media/%s.png" % ui_page.name)


func go_to(page: Variant) -> void:
	await hide_ui()
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
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	visible = false
	for child: Node in get_children():
		if child is UiPage:
			# inject ui in child page
			child.set("ui", self)
	_preset_all_at_ready.call_deferred()


func _preset_all_at_ready() -> void:
	for child: Node in get_children():
		if child is UiPage:
			await child.preset_ui()
	visible = true
	is_preset_ready = true
	preset_ready.emit()


func _unhandled_input(event: InputEvent) -> void:
	# I think this could be simplified somehow, but I'm not getting it just yet
	# If nothing focused, trying to focus next will focus something
	var focus_owner: Node = get_viewport().gui_get_focus_owner()
	#print("focus owner is ", focus_owner)
	if (
		(event.is_action_pressed("ui_focus_next") or event.is_action_pressed("ui_focus_controls"))
		and not focus_owner
	):
		_focus_something()
		get_viewport().set_input_as_handled()
		return

	# If something focused, ui_cancel will release focus
	if event.is_action_pressed("ui_cancel") and focus_owner:
		focus_owner.release_focus()
		get_viewport().set_input_as_handled()
		return

	if (event is InputEventJoypadMotion or event is InputEventJoypadButton) and focus_owner == null:
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
			if button.visible and button.focus_mode != Control.FOCUS_NONE:
				button.grab_focus()
				break


func _on_focus_changed(control: Control) -> void:
	# Can do something interesting with focus here...
	pass
