extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready():
    %Back.pressed.connect(_on_back)
    %MarkdownLabel.display_file("res://ATTRIBUTION.md")

func _on_back():
    GuiTransitions.go_to("MainMenu")
