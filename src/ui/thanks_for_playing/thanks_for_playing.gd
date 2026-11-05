@tool
extends UiPage

@export var thank_you_image: Texture2D:
	set(texture):
		thank_you_image = texture
		texture_rect.texture = thank_you_image

@onready var texture_rect: TextureRect = $TextureRect


func _input(event: InputEvent) -> void:
	if Engine.is_editor_hint() or not visible:
		return
	if event.is_pressed():
		await UI.hide_ui(self)
		get_tree().change_scene_to_file("res://main.tscn")
