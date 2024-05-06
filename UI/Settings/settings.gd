extends CenterContainer


var _previous_layout = "MainMenu"
var _audio_bus_name_idx_mapping = {}


func _ready():
    %Back.pressed.connect(_on_back)
    call_deferred("_update_audio_sliders")

    for idx in range(0, AudioServer.bus_count):
        _audio_bus_name_idx_mapping[AudioServer.get_bus_name(idx)] = idx
    #print(JSON.stringify(_audio_bus_name_idx_mapping))

    for control in %Audio.find_children("*", "HSlider"):
        control.value_changed.connect(_on_audio_hslider_value_changed.bind(control.name))


func _input(_event):
    # $GuiTransition._status is non-zero while transition is active
    if visible and not $GuiTransition._status and Input.is_action_just_pressed("ui_cancel"):
        get_viewport().set_input_as_handled()
        GuiTransitions.go_to(_previous_layout)


func _on_back():
    # TODO: add test for coming from pause menu or main menu, maybe if game active
    GuiTransitions.go_to(_previous_layout)


func _on_audio_hslider_value_changed(value, bus_name):
    print(bus_name, value/100)
    AudioServer.set_bus_volume_db(_audio_bus_name_idx_mapping[bus_name], linear_to_db(value/100))


func _update_audio_sliders():
    for bus_name in _audio_bus_name_idx_mapping:
        var linear = db_to_linear(AudioServer.get_bus_volume_db(_audio_bus_name_idx_mapping[bus_name]))
        var control = %Audio.find_child(bus_name)
        if control:
            control.value = int(linear * 100)
