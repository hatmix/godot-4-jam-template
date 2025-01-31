# GdUnit generated TestSuite
class_name MainMenuTest
extends GdUnitTestSuite
@warning_ignore("unused_parameter")
@warning_ignore("return_value_discarded")


# Ensure the UI "page" can be run directly for development convenience
func test_as_run_current_scene() -> void:
	var runner: GdUnitSceneRunner = scene_runner("res://ui/main_menu/main_menu.tscn")
	# Since we use string names when connecting buttons
	assert_str(runner.scene().name).is_equal("MainMenu")


func test__on_focus_changed() -> void:
	var _runner: GdUnitSceneRunner = scene_runner("res://ui/main_menu/main_menu.tscn")
