# GdUnit generated TestSuite
class_name UiTest
extends GdUnitTestSuite
@warning_ignore("unused_parameter")
@warning_ignore("return_value_discarded")

#func test_resolution(do_skip = DisplayServer.get_name().contains("headless")) -> void:
# Testing what CI runners have for DisplayServer backend
# We know it can't match headless or it would be skipped, so match headless
# to get the test failure to tell us the actual name
#assert_str(DisplayServer.get_name()).is_equal_ignoring_case("headless")

# Each UiPage with a visible control should be able to focus something to support
# joypad and pure keyboard ui navigation...


func test__focus_something() -> void:
	var runner: GdUnitSceneRunner = scene_runner("res://ui/ui.tscn")

	var pages: Array[Node] = runner.scene().get_children()
	for page: Node in pages:
		if page is UiPage:
			page = page as UiPage
			# Skip pages with nothing to focus
			if page.name in ["InGameMenuOverlay", "MessageBoard"]:
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
	GUIDEInputFormatter.cleanup()
