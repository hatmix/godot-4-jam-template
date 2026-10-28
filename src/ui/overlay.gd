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
	UI.scale_changed.connect(_on_ui_scale_changed)


func _on_ui_scale_changed() -> void:
	scale = Vector2.ONE / UI.scale
	position = -UI.offset / UI.scale
