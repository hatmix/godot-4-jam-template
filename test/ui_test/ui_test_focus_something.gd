# GdUnit generated TestSuite
class_name UiTest
extends GdUnitTestSuite
@warning_ignore("unused_parameter")
@warning_ignore("return_value_discarded")

#var runner: GdUnitSceneRunner = scene_runner("res://ui/controls/controls.tscn")
#var runner: GdUnitSceneRunner = scene_runner("res://ui/credits/credits.tscn")
#var runner: GdUnitSceneRunner = scene_runner("res://ui/game/game.tscn")
#var runner: GdUnitSceneRunner = scene_runner("res://ui/how_to_play/how_to_play.tscn")

#var runner: GdUnitSceneRunner = scene_runner("res://ui/notifications/message_board.tscn")
#var runner: GdUnitSceneRunner = scene_runner("res://ui/pause_menu/pause_menu.tscn")
#var runner: GdUnitSceneRunner = scene_runner("res://ui/settings/settings.tscn")


# Each ui "page" should have a visible control that can grab focus to support
# joypad and pure keyboard ui navigation
func test__focus_something() -> void:
	var runner: GdUnitSceneRunner = scene_runner("res://ui/ui.tscn")

	var pages: Array[Node] = runner.scene().get_children()
	for page: Node in pages:
		if page is CanvasItem:
			# Skip pages with no buttons or that don't need to grab focus
			if page.name in ["Game", "InGameMenuOverlay", "MessageBoard"]:
				continue
			runner.invoke("go_to", page)
			var focused: Variant = get_viewport().gui_get_focus_owner()
			if focused:
				focused.release_focus()

			runner.invoke("_focus_something")
			focused = get_viewport().gui_get_focus_owner()
			(
				assert_object(focused)
				. override_failure_message("ui page '%s' has no focused button" % page.name)
				. is_instanceof(Button)
			)
			# Ensure we don't focus a hidden button (but this doesn't test parents)
			assert_bool(focused.visible).is_true()
