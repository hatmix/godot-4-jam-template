extends CanvasLayer

var _skip_on_visibility_changed: bool = false


func hide_ui(page: Variant = null) -> void:
	if page:
		var ui_page: CanvasItem = _resolve_ui_page(page)
		if ui_page:
			ui_page.hide()
	else:
		_skip_on_visibility_changed = true
		for child: Node in get_children():
			if child is CanvasItem:
				child.hide()
		_skip_on_visibility_changed = false
		_on_visibility_changed()


func show_ui(page: Variant) -> void:
	var ui_page: CanvasItem = _resolve_ui_page(page)
	if ui_page:
		ui_page.show()


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
	elif node_or_name is String:
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
			child.visibility_changed.connect(_on_visibility_changed)
	show()


func _on_visibility_changed() -> void:
	if _skip_on_visibility_changed:
		return
	# If nothing focused, automatically grab_focus on first button found in shown
	if get_viewport().gui_get_focus_owner() == null:
		for child: Node in get_children():
			if child is Control and child.visible:
				for button: Button in child.find_children("*", "Button"):
					# Helpful for discovering focus goes to a hidden button
					#print("Found button %s" % button.name)
					button.grab_focus()
					break
				break
