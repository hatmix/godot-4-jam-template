# GdUnit generated TestSuite
class_name GameUiTest
extends GdUnitTestSuite
@warning_ignore("unused_parameter")
@warning_ignore("return_value_discarded")


# Ensure the UI "page" can be run directly for development convenience
func test_as_run_current_scene() -> void:
	var runner: GdUnitSceneRunner = scene_runner("res://ui/game/game_ui.tscn")
	# Since we use string names when connecting buttons
	assert_str(runner.scene().name).is_equal("Game")

	# Need to determine why this is needed only for this scene's test
	GUIDEInputFormatter.cleanup()
