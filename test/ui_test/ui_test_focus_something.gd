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


# Each ui "page" should have a visible control that can grab focus to support
# joypad and pure keyboard ui navigation
func test__focus_something() -> void:
	var runner: GdUnitSceneRunner = scene_runner("res://ui/ui.tscn")

	var pages: Array[Node] = runner.scene().get_children()
	for page: Node in pages:
		if page is CanvasItem:
			# Skip pages with no buttons or that don't need to grab focus
			if page.name in ["InGameMenuOverlay", "MessageBoard"]:
				continue
			runner.invoke("go_to", page)
			var focused: Variant = get_viewport().gui_get_focus_owner()
			if focused:
				focused.release_focus()

			runner.invoke("_focus_something", InputEventJoypadButton.new())
			focused = get_viewport().gui_get_focus_owner()

			# Not captured when prevent set
			if runner.get_property("prevent_joypad_focus_capture") == true:
				(
					assert_object(focused)
					. override_failure_message(
						"ui page '%s' with prevent_joypad_focus_capture captured focus" % page.name
					)
					. is_null()
				)
			# Otherwise captured
			else:
				(
					assert_object(focused)
					. override_failure_message("ui page '%s' has no focused button" % page.name)
					. is_instanceof(Button)
				)
				# Ensure we don't focus a hidden button (but this doesn't test parents)
				assert_bool(focused.visible).is_true()
