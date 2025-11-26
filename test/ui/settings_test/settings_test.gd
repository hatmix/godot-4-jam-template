# GdUnit generated TestSuite
class_name SettingsTest
extends GdUnitTestSuite
@warning_ignore("unused_parameter")
@warning_ignore("return_value_discarded")

# Need to skip settings under headless testing, as it uses get_viewport()
# Ensure the UiPage can be run directly for development convenience
func test_as_run_current_scene(_do_skip := DisplayServer.get_name() == "headless") -> void:
	var runner: GdUnitSceneRunner = scene_runner("res://src/ui/settings/settings.tscn")
	# Because there is an autoload name "Settings", the "Settings" page will get a different name
	# when added to the tree on its own.
	assert_object(runner.scene()).is_instanceof(Control)
