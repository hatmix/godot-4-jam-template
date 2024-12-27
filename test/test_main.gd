class_name TestMainTest
extends GdUnitTestSuite

func test_main():
	var script_under_test = auto_free(load("res://main.gd").new())
	assert_int(script_under_test.test_value).is_equal(1)
