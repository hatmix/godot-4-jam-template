class_name EventIconMapping
extends Resource

enum IconSet { KENNEY_STANDARD, KENNEY_1_BIT }

const MISSING_KEY_ICON := "generic_button_square_outline"
const MISSING_MOUSE_ICON := "mouse_outline"
const MISSING_JOYPAD_ICON := "controller_generic"

static var _keystring_filename_lookup := {
    "equal": "equals",
    "bracketleft": "bracket_open",
    "bracketright": "bracket_close",
    "backslash": "slash_back",
    "slash": "slash_forward",
    "pageup": "page_up",
    "pagedown": "page_down",
    "up": "arrow_up",
    "left": "arrow_left",
    "down": "arrow_down",
    "right": "arrow_right",
    "pause": "",
    "subtract": "minus",
    "divide": "slash_forward",
    "add": "numpad_plus",
    "multiply": "asterisk",
    "clear": "",
    "kp enter": "kp numpad_enter",
}

static var images: Dictionary = {
    IconSet.KENNEY_STANDARD: [],
    IconSet.KENNEY_1_BIT: [],
}
static var path_to_image: Dictionary = {
    IconSet.KENNEY_STANDARD: {},
    IconSet.KENNEY_1_BIT: {},
}
static var group: Dictionary = {
    IconSet.KENNEY_STANDARD: preload("res://addons/input_event_icons/icons/kenney-standard.tres"),
    IconSet.KENNEY_1_BIT: preload("res://addons/input_event_icons/icons/kenney-1-bit.tres"),
}

var icon_set: IconSet = IconSet.KENNEY_STANDARD


func _init() -> void:
    for iconset: int in IconSet.values():
        if images[iconset].size() == 0:
            group[iconset].load_all_into(images[iconset])
            for idx: int in range(group[iconset].paths.size()):
                path_to_image[group[iconset].paths[idx]] = images[iconset][idx]


func _get_full_path(icon_filename: String) -> String:
    return "%s/%s.png" % [group[icon_set].base_folder, icon_filename]


func _texture_from_filename(icon_filename: String, default: String) -> Texture2D:
    icon_filename = _get_full_path(icon_filename)
    if icon_filename in path_to_image:
        return path_to_image[icon_filename]
    return path_to_image[_get_full_path(default)]


func get_icon_for_event(event: InputEvent) -> EventIcon:
    if event is InputEventKey:
        return _parse_key_event(event)
    if event is InputEventMouseButton:
        return _parse_mouse_button_event(event)
    if event is InputEventJoypadButton:
        return _parse_joypad_button_event(event)
    if event is InputEventJoypadMotion:
        return _parse_joypad_motion_event(event)
    printerr("EventIconMapping found no icon for %s" % JSON.stringify(event))
    return UnsupportedEventIcon.new()


func _parse_joypad_motion_event(event: InputEventJoypadMotion) -> EventIcon:
    var icon_filename: String
    var regex = RegEx.create_from_string("(Right|Left) Stick (X|Y)-Axis|(Right|Left) Trigger")
    var matches := regex.search_all(event.as_text())
    for rematch: RegExMatch in matches:
        if rematch.strings[0].contains("Stick"):
            var stick := rematch.strings[1].substr(0, 1).to_lower()
            var dir: String
            match rematch.strings[2]:
                "X":
                    dir = "right" if event.axis_value > 0 else "left"
                "Y":
                    dir = "down" if event.axis_value > 0 else "up"
            icon_filename = "xbox_stick_%s_%s" % [stick, dir]
        elif rematch.strings[0].contains("Trigger"):
            if rematch.strings[3] == "Left":
                icon_filename = "xbox_lt"
            else:
                icon_filename = "xbox_rt"

    if icon_filename == null:
        printerr("EventIconMapping parse error for event %s" % JSON.stringify(event))
        icon_filename = MISSING_JOYPAD_ICON
    var event_icon := EventIcon.new()
    event_icon.texture = _texture_from_filename(icon_filename, MISSING_JOYPAD_ICON)
    return event_icon


func _parse_joypad_button_event(event: InputEventJoypadButton) -> EventIcon:
    var icon_filename: String
    var regex = RegEx.create_from_string(
        "(?:Bottom (\\w+)|Sony (\\w+)|Xbox (\\w+)|Nintendo (\\w+))|D-pad (\\w+)"
    )
    var matches := regex.search_all(event.as_text())
    for rematch: RegExMatch in matches:
        if rematch.strings[0].contains("Xbox"):
            if rematch.strings[3] in ["A", "B", "X", "Y"]:
                icon_filename = "xbox_button_color_%s" % rematch.strings[3].to_lower()
            elif rematch.strings[3] in ["L", "R"]:
                icon_filename = "xbox_stick_side_%s" % rematch.strings[3].to_lower()
            elif rematch.strings[3] in ["LB", "RB"]:
                icon_filename = "xbox_%s" % rematch.strings[3].to_lower()
            else:
                icon_filename = "xbox_button_%s" % rematch.strings[3].to_lower()
        # D-pad doesn't follow convention of other buttons
        if rematch.strings[0].contains("D-pad"):
            icon_filename = "xbox_dpad_%s" % rematch.strings[5].to_lower()

    if icon_filename == null:
        printerr("EventIconMapping parse error for event %s" % JSON.stringify(event))
        icon_filename = MISSING_JOYPAD_ICON
    var event_icon := EventIcon.new()
    event_icon.texture = _texture_from_filename(icon_filename, MISSING_JOYPAD_ICON)
    return event_icon


func _parse_mouse_button_event(event: InputEventMouseButton) -> EventIcon:
    var icon_filename := MISSING_KEY_ICON
    match event.button_index:
        1:
            icon_filename = "mouse_left"
        2:
            icon_filename = "mouse_right"
        3:
            icon_filename = "mouse_scroll"
        4:
            icon_filename = "mouse_scroll_up"
        5:
            icon_filename = "mouse_scroll_down"

    if icon_filename == null:
        printerr("EventIconMapping parse error for event %s" % JSON.stringify(event))
        icon_filename = MISSING_MOUSE_ICON
    var event_icon := EventIcon.new()
    event_icon.texture = _texture_from_filename(icon_filename, MISSING_MOUSE_ICON)
    return event_icon


func _parse_key_event(event: InputEventKey) -> KeyboardEventIcon:
    var icon_filename := MISSING_KEY_ICON
    var event_icon := KeyboardEventIcon.new()
    var keycode: int
    var keystring: String

    # Events are matched by keycode, then by keycode_physical
    # https://docs.godotengine.org/en/stable/classes/class_inputeventkey.html
    if event.keycode != KEY_NONE:
        keycode = event.keycode
    elif OS.get_name() != "Web":
        keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
    else:
        keycode = event.physical_keycode
    keystring = OS.get_keycode_string(keycode).to_lower()

    if keystring in _keystring_filename_lookup:
        keystring = _keystring_filename_lookup[keystring]

    if keystring.contains("kp "):
        keystring = keystring.replace("kp ", "")
        event_icon.is_numpad = true

    if keystring != "":
        icon_filename = "keyboard_%s" % keystring
    event_icon.texture = _texture_from_filename(icon_filename, MISSING_KEY_ICON)
    return event_icon


class EventIcon:
    var texture: Texture2D


class KeyboardEventIcon:
    extends EventIcon
    var is_numpad: bool


class UnsupportedEventIcon:
    extends EventIcon
