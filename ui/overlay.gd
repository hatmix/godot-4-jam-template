extends ColorRect

# Sits between game and UI and visible while game is paused. Right now, just
# applies a darkening effect.


func _process(_delta: float) -> void:
	if get_tree().paused == true:
		visible = true
	else:
		visible = false
