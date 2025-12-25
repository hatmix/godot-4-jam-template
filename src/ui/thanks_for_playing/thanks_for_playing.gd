@tool
extends UiPage

@export var thank_you_image: Texture2D:
	set(texture):
		thank_you_image = texture
		texture_rect.texture = thank_you_image

@onready var texture_rect: TextureRect = $TextureRect


func _process(_delta: float) -> void:
	if visible and Input.is_anything_pressed():
		await ui.hide_ui(self)
		get_tree().change_scene_to_file("res://main.tscn")
