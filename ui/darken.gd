extends ColorRect


func _process(delta: float) -> void:
	if get_tree().paused == true:
		visible = true
	else:
		visible = false
