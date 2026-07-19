class_name TestMainTest
extends GdUnitTestSuite


func test_main():
	var runner: GdUnitSceneRunner = scene_runner("res://main.tscn")
	assert_str(runner.scene().name).is_equal("Main")
