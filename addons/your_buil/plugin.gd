@tool
extends EditorPlugin

var _exporter: EditorExportPlugin = preload("exporter.gd").new()


func _enter_tree() -> void:
	add_export_plugin(_exporter)


func _exit_tree() -> void:
	remove_export_plugin(_exporter)
