extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug("bitwes/Gut", {"tag": "v9.2.1", "dev": true})
	plug("Maaack/Godot-UI-Sound-Controller", {"tag": "v0.5.0"})
	plug("daenvil/MarkdownLabel", {"tag": "v1.2.0"})
	plug("murikistudio/simple-gui-transitions", {"tag": "v0.2.2", "exclude": ["example"]})
	plug("Pennycook/godot-input-prompts", {"tag": "icon-styles", "exclude": ["demo"]})
