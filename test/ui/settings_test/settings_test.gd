# GdUnit generated TestSuite
class_name SettingsTest
extends GdUnitTestSuite

var is_headless: bool = DisplayServer.get_name().contains("headless")


# Need to skip settings under headless testing, as it uses get_viewport()
@warning_ignore("inferred_declaration")
func before(_do_skip := is_headless) -> void:
	pass


# Ensure the UiPage can be run directly for development convenience
@warning_ignore("inferred_declaration")
func test_as_run_current_scene(_do_skip := is_headless) -> void:
	var runner: GdUnitSceneRunner = scene_runner("res://src/ui/settings/settings.tscn")
	# Because there is an autoload name "Settings", the "Settings" page will get a different name
	# when added to the tree on its own.
	assert_object(runner.scene()).is_instanceof(Control)
