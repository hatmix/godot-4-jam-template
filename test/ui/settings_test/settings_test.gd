# GdUnit generated TestSuite
class_name SettingsTest
extends GdUnitTestSuite


# Ensure the UiPage can be run directly for development convenience
@warning_ignore("inferred_declaration")
func test_as_run_current_scene() -> void:
	var runner: GdUnitSceneRunner = scene_runner("res://src/ui/settings/settings.tscn")
	# Because there is an autoload name "Settings", the "Settings" page will get a different name
	# when added to the tree on its own.
	assert_object(runner.scene()).is_instanceof(UiPage)
