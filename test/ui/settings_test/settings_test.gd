# GdUnit generated TestSuite
class_name SettingsTest
extends GdUnitTestSuite
@warning_ignore("unused_parameter")
@warning_ignore("return_value_discarded")


# Ensure the UI "page" can be run directly for development convenience
func test_as_run_current_scene() -> void:
	var runner: GdUnitSceneRunner = scene_runner("res://ui/settings/settings.tscn")
	# Because there is an autoload name "Settings", the "Settings" page will get a different name
	# when added to the tree on its own.
	assert_object(runner.scene()).is_instanceof(Control)
