extends ColorRect

# Sits between game and UI and visible while game is paused. Right now, just
# applies a darkening effect.


func _ready() -> void:
	_hook_ui_scale_changed.call_deferred()


func _process(_delta: float) -> void:
	if get_tree().paused == true:
		visible = true
	else:
		visible = false


func _hook_ui_scale_changed() -> void:
	var ui: Node = get_parent()
	if is_instance_valid(ui) and ui is UI:
		get_parent().scale_changed.connect(_on_ui_scale_changed)


func _on_ui_scale_changed() -> void:
	var ui: Node = get_parent()
	if is_instance_valid(ui) and ui is UI:
		scale = Vector2.ONE / ui.scale
		position = -ui.offset / ui.scale
