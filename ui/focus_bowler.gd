extends Sprite2D

var position_tween: Tween # position, global_position
var behavior_tween: Tween # offset, rotation, scale, modulate

@onready var anim_player: AnimationPlayer = $AnimationPlayer


func go_to(position: Vector2, duration: float = 0.25) -> void:
	if position_tween:
		position_tween.kill()
	position_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	position_tween.tween_property(self, "global_position", position, duration)
	await wiggle()


func wiggle() -> void:
	anim_player.play("Wiggle")
	await anim_player.animation_finished


func fade_out() -> void:
	if behavior_tween:
		behavior_tween.kill()
	behavior_tween = create_tween()
	behavior_tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)
	await behavior_tween.finished
	visible = false


func reset_behavior() -> void:
	if behavior_tween:
		behavior_tween.kill()
	behavior_tween = create_tween()
	behavior_tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	behavior_tween.tween_property(self, "rotation", deg_to_rad(30), 0.1)
	behavior_tween.tween_property(self, "scale", Vector2.ONE * 0.25, 0.1)
	behavior_tween.tween_property(self, "offset", Vector2.ZERO, 0.1)
	await behavior_tween.finished


func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	pass
