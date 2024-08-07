extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug("bitwes/Gut", {"tag": "v9.2.1", "dev": true})
	plug("Maaack/Godot-UI-Sound-Controller", {"tag": "v0.5.0"})
	plug("daenvil/MarkdownLabel", {"tag": "v1.2.0"})
	plug("murikistudio/simple-gui-transitions", {"tag": "v0.4.0", "exclude": ["example"]})
	plug("derkork/godot-resource-groups", {"tag": "v0.3.0", "exclude": ["csharp"]})
	plug("hatmix/godot-input-event-icons", {"exclude": ["gd-plug"]})
