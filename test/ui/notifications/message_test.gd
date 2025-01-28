# GdUnit generated TestSuite
class_name MessageTest
extends GdUnitTestSuite
@warning_ignore("unused_parameter")
@warning_ignore("return_value_discarded")


# Ensure the UI "page" can be run directly for development convenience
func test_as_run_current_scene() -> void:
	var runner: GdUnitSceneRunner = scene_runner("res://ui/notifications/message.tscn")
	# TBD
	assert_str(runner.scene().name).is_equal("Message")
