extends CenterContainer


func _ready():
	%Back.pressed.connect(func(): GuiTransitions.go_to("MainMenu"))
	%MarkdownLabel.display_file("res://ATTRIBUTION.md")


