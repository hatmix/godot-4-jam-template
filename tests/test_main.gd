extends GutTest

func test_main():
    var scene = autofree(load("res://main.tscn"))
    var instance = add_child_autofree(scene.instantiate())
    assert_not_null(instance)
    assert_eq(instance.name, "Main")
