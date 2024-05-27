extends CenterContainer


func _ready() -> void:
	%Back.pressed.connect(GuiTransitions.go_to.bind("MainMenu"))
	%MarkdownLabel.display_file("res://ATTRIBUTION.md")
