@tool
class_name InputEventButton
extends Button

@export var icon_set: EventIconMapping.IconSet
@export var input_event: InputEvent:
    set = set_input_event
## Use self_modulate color to indicate the event was a numpad key
@export var show_numpad: bool = true
## Color of self_modulate for numpad events
@export_color_no_alpha var show_numpad_color: Color = Color("#E73246")


func set_input_event(event: InputEvent) -> void:
    input_event = event
    _update_icon()
    queue_redraw()


func _update_icon() -> void:
    var event_icon_mapping := EventIconMapping.new()
    event_icon_mapping.icon_set = icon_set
    var event_icon: EventIconMapping.EventIcon = event_icon_mapping.get_icon_for_event(input_event)
    if not event_icon is EventIconMapping.UnsupportedEventIcon:
        icon = event_icon.texture
        if show_numpad:
            if event_icon is EventIconMapping.KeyboardEventIcon:
                event_icon = event_icon as EventIconMapping.KeyboardEventIcon
                self_modulate = show_numpad_color if event_icon.is_numpad else Color.WHITE
            else:
                self_modulate = Color.WHITE
