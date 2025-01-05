@tool
extends EditorPlugin


func _enter_tree() -> void:
    add_custom_type(
        "InputEventIcon",
        "TextureRect",
        preload("input_event_icon.gd"),
        preload("res://addons/input_event_icons/icons/kenney-standard/xbox_button_color_a.png")
    )
    add_custom_type(
        "InputEventButton",
        "Button",
        preload("input_event_button.gd"),
        preload("res://addons/input_event_icons/icons/kenney-standard/xbox_button_color_x.png")
    )


func _exit_tree() -> void:
    remove_custom_type("InputEventIcon")
    remove_custom_type("InputEventButton")
