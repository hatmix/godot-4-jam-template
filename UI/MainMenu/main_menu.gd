extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready():
    %Credits.pressed.connect(func(): GuiTransitions.go_to("Credits"))
    %Exit.pressed.connect(get_tree().call_deferred.bind("quit"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
