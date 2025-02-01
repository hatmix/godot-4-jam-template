extends UiPage

const REMAP_INPUT_BUTTON_SCENE: PackedScene = preload("res://ui/controls/remap_input_button.tscn")

@export var remap_mapping_contexts: Array[GUIDEMappingContext]
@export var icon_size: int:
	set(value):
		icon_size = value
		_formatter = GUIDEInputFormatter.new(icon_size)

var _remapper: GUIDERemapper = GUIDERemapper.new()
var _formatter: GUIDEInputFormatter
var _remapping_config: GUIDERemappingConfig


func _ready() -> void:
	%InputPanel.visible = false
	%Back.pressed.connect(go_back)
	_init_actions()


func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_back"):
		get_viewport().set_input_as_handled()
		go_back()


func _init_actions() -> void:
	_remapping_config = Settings.load_controls()
	GUIDE.set_remapping_config(_remapping_config)
	_remapper.initialize(remap_mapping_contexts, _remapping_config)

	for context: GUIDEMappingContext in remap_mapping_contexts:
		var items: Array[GUIDERemapper.ConfigItem] = _remapper.get_remappable_items(context)
		for item: GUIDERemapper.ConfigItem in items:
			var action_label: Label = Label.new()
			action_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			action_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			action_label.text = item.display_name
			action_label.custom_minimum_size.y = icon_size

			var bound_input: GUIDEInput = _remapper.get_bound_input_or_null(item)
			var remap_input: Control = REMAP_INPUT_BUTTON_SCENE.instantiate()
			remap_input.remapper = _remapper
			remap_input.formatter = _formatter
			remap_input.item = item
			if (
				bound_input is GUIDEInputJoyAxis1D
				or bound_input is GUIDEInputJoyAxis2D
				or bound_input is GUIDEInputJoyBase
				or bound_input is GUIDEInputJoyButton
			):
				%ControllerActions.add_child(action_label)
				%ControllerActions.add_child(remap_input)
				remap_input.button.pressed.connect(_get_new_input_for_action.bind(item, true))

			else:
				%KeyboardMouseActions.add_child(action_label)
				%KeyboardMouseActions.add_child(remap_input)
				remap_input.button.pressed.connect(_get_new_input_for_action.bind(item))
			remap_input.button.custom_minimum_size = Vector2(icon_size, icon_size)


func _get_new_input_for_action(item: GUIDERemapper.ConfigItem, for_joypad: bool = false) -> void:
	%InputPanel.for_joypad = for_joypad
	%InputPanel.item = item
	%InputPanel.visible = true
	#print("get new input for action %s" % action)

	await %InputPanel.popup_hide
	var input: GUIDEInput = %InputPanel.input
	if input == null:
		return

	# check for collisions
	var collisions: Array[GUIDERemapper.ConfigItem] = _remapper.get_input_collisions(item, input)

	# if any collision is from a non-bindable mapping, we cannot use this input
	if collisions.any(func(it: GUIDERemapper.ConfigItem) -> bool: return not it.is_remappable):
		return

	# unbind the colliding entries.
	for collision: GUIDERemapper.ConfigItem in collisions:
		_remapper.set_bound_input(collision, null)

	# now bind the new input
	_remapper.set_bound_input(item, input)

	# we apply & save at every change
	var config: GUIDERemappingConfig = _remapper.get_mapping_config()
	GUIDE.set_remapping_config(config)
	Globals.controls_changed.emit(config)
