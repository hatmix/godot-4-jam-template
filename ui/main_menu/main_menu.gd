extends UiPage

# TODO: Add a title and/or background art to main_menu.tscn

@export var pointer_icon: Texture2D = load("res://ui/assets/icons/finger-point-right.png")

@onready var title: TextureRect = $Title
@onready var buttons: VBoxContainer = %Buttons
@onready var git_info: GridContainer = $GitInfo
@onready var anim_player: AnimationPlayer = $Title/AnimationPlayer


func show_ui() -> void:
	if visible:
		return
	if anim_player.is_playing():
		anim_player.stop()
	title.pivot_offset = title.size / 2
	title.scale = Vector2.ZERO
	buttons.pivot_offset = buttons.size / 2
	buttons.scale = Vector2.ZERO
	git_info.visible = false
	visible = true

	var title_tween: Tween = title.create_tween().set_ease(Tween.EASE_OUT).set_trans(
		Tween.TRANS_ELASTIC
	)
	title_tween.tween_property(title, "scale", Vector2.ONE, 1.0)
	title_tween.tween_callback(anim_player.play.bind("Dance"))

	var buttons_tween: Tween = buttons.create_tween().set_ease(Tween.EASE_OUT).set_trans(
		Tween.TRANS_ELASTIC
	)
	buttons_tween.tween_interval(0.5)
	buttons_tween.tween_property(buttons, "scale", Vector2.ONE, 1.0)

	await get_tree().create_timer(1.0).timeout
	git_info.visible = true


func hide_ui() -> void:
	anim_player.stop()
	var title_tween: Tween = title.create_tween().set_ease(Tween.EASE_IN).set_trans(
		Tween.TRANS_CUBIC
	)
	title_tween.tween_property(title, "scale", Vector2.ZERO, 0.5)

	var buttons_tween: Tween = buttons.create_tween().set_ease(Tween.EASE_IN).set_trans(
		Tween.TRANS_CUBIC
	)
	buttons_tween.tween_interval(0.25)
	buttons_tween.tween_property(buttons, "scale", Vector2.ZERO, 0.3)

	await buttons_tween.finished
	visible = false


func _ready() -> void:
	call_deferred("_connect_buttons")
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

	if OS.get_name() == "Web":
		%Exit.hide()


func _process(delta: float) -> void:
	if not visible:
		return


func _connect_buttons() -> void:
	if ui:
		%Play.pressed.connect(_start_game)
		%HowToPlay.pressed.connect(ui.go_to.bind("HowToPlay"))
		%Settings.pressed.connect(ui.go_to.bind("Settings"))
		%Controls.pressed.connect(ui.go_to.bind("Controls"))
		%Credits.pressed.connect(ui.go_to.bind("Credits"))
		%Exit.pressed.connect(get_tree().call_deferred.bind("quit"))


func _start_game() -> void:
	# TODO: Consider adding some kind of scene transition
	await hide_ui()
	get_tree().change_scene_to_file("res://game/game.tscn")


func _on_focus_changed(control: Control) -> void:
	if not visible:
		return
	for button: Button in %Buttons.get_children():
		if button == control:
			pass
			#button.icon = pointer_icon
		else:
			pass
			#button.icon = null
