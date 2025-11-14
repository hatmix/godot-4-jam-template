extends UiPage


func _process(delta: float) -> void:
	if visible:
		move_to_front()
