extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready():
    %Play.pressed.connect(func(): GuiTransitions.go_to("Game"))
    %Settings.pressed.connect(func(): GuiTransitions.go_to("Settings"))
    %Credits.pressed.connect(func(): GuiTransitions.go_to("Credits"))
    %Exit.pressed.connect(get_tree().call_deferred.bind("quit"))



