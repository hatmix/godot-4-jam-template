@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("ProjectUISoundController", "res://addons/maaacks_ui_sound_controller/base/scenes/Autoloads/ProjectUISoundController.tscn")

func _exit_tree():
	remove_autoload_singleton("ProjectUISoundController")
