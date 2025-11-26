class_name UI
extends CanvasLayer

signal preset_ready
signal scale_changed

var browser_on_mobile: bool = false

var is_preset_ready: bool = false
var page_lookup: Dictionary[String, UiPage] = {}
var saved_state: Array[Array] = []
var ui_scale: Vector2 = Vector2.ONE:
	set(v):
		if ui_scale.is_equal_approx(v):
			return
		ui_scale = v
		scale = v
		_handle_scaled_or_resized()

# Order matters b/c move_to_front called in this order
@onready var pause_menus: Array[CanvasItem] = [
	$InGameMenuOverlay, $HowToPlay, $Settings, $Controls, $MessageBoard, $PauseMenu
]


func hide_ui(page: Variant = null) -> void:
	if page:
		var ui_page: UiPage = _resolve_ui_page(page)
		if ui_page and ui_page.visible:
			@warning_ignore("redundant_await")
			await ui_page.hide_ui()
	else:
		for child: Node in get_children():
			if child is UiPage and child.visible:
				await child.hide_ui()
				child.hide()


func show_ui(page: Variant) -> void:
	print("show_ui ", page)
	var ui_page: UiPage = _resolve_ui_page(page)
	if ui_page and not ui_page.visible:
		ui_page.show()
		if ui_page.has_method("show_ui"):
			@warning_ignore("redundant_await")
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


func get_showing() -> Array[UiPage]:
	var shown: Array[UiPage] = []
	for child: Node in get_children():
		if child is UiPage and child.visible:
			shown.append(child)
	return shown


func push_state() -> void:
	saved_state.append(get_showing())


func pop_state() -> void:
	if saved_state.size() == 0:
		push_warning("No saved_state found. Call push_state() before pop_state()")
		return
	var state: Array[UiPage] = saved_state.pop_front()
	for page: UiPage in page_lookup.values():
		if page in state:
			show_ui(page)
		else:
			hide_ui(page)


# ensures the pause menu UiPages are in front of any other elements in the
# UI canvas layer
func pause_move_to_front() -> void:
	for node: CanvasItem in pause_menus:
		node.move_to_front()


func _resolve_ui_page(node_or_name: Variant) -> Node:
	if node_or_name is UiPage:
		return node_or_name
	if node_or_name is String:
		var node: Variant = page_lookup.get(node_or_name, null)
		if node is UiPage:
			return node
	push_error("Can't find ui page '%s'" % node_or_name)
	return


func _ready() -> void:
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	get_viewport().size_changed.connect(_handle_scaled_or_resized)
	visible = false

	# Detect browser on mobile
	if (
		OS.has_feature("web_android")
		or OS.has_feature("web_ios")
		or (Globals.show_virtual_controls and OS.has_feature("debug"))
	):
		browser_on_mobile = true

	for child: Node in get_children():
		if child is UiPage:
			# inject ui in child page
			child.set("ui", self)
			# add to lookup
			page_lookup[child.name] = child
	_preset_all_at_ready.call_deferred()


func _preset_all_at_ready() -> void:
	for child: Node in get_children():
		if child is UiPage:
			await child.preset_ui()
	visible = true
	is_preset_ready = true
	#print("UI preset ready")
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


func _on_focus_changed(_control: Control) -> void:
	# Can do something interesting with focus here...
	pass


func _process(_delta: float) -> void:
	if not scale.is_equal_approx(ui_scale):
		scale = ui_scale
		scale_changed.emit()


func _handle_scaled_or_resized() -> void:
	var vp_rect: Rect2i = get_viewport().get_visible_rect()
	var margin_x: int = int(0.5 * vp_rect.size.x * (scale.x - 1))
	var margin_y: int = int(0.5 * vp_rect.size.y * (scale.y - 1))
	offset = Vector2(-margin_x, -margin_y)
	#prints(get_viewport().get_visible_rect(), offset)
	scale_changed.emit()
