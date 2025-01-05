extends "res://addons/gd-plug/plug.gd"


func _plugging():
	#plug("bitwes/Gut", {"tag": "v9.2.1", "dev": true})
	#plug("MikeSchulze/gdUnit4", {"tag": "v4.5.0", "dev": true})
	plug("viniciusgerevini/godot-aseprite-wizard", {"tag": "v8.2.0-4", "dev": true})
	plug("Maran23/script-ide", {"commit": "1624773accaf8ad1698d38bda61105951b1ffda8", "dev": true})
	plug("Inspiaaa/ThemeGen", {"tag": "v1.1", "include":["ThemeGen/ThemeGen"], "dev": true})

	plug("Maaack/Godot-UI-Sound-Controller", {"tag": "v0.5.0"})
	plug("daenvil/MarkdownLabel", {"tag": "v1.2.0"})
	plug("murikistudio/simple-gui-transitions", {"tag": "v0.4.0", "exclude": ["example"]})
	plug("derkork/godot-resource-groups", {"tag": "v0.4.1", "exclude": ["csharp"]})
	plug("hatmix/godot-input-event-icons", {"exclude": ["gd-plug"]})
	plug("godotneers/G.U.I.D.E", {"tag": "v0.0.4", "include": ["_assets", "addons"]})
