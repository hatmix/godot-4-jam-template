# Godot 4 Jam Template

Opinionated quick start template for game jams built on [hatmix/godot-4-ci](https://github.com/hatmix/godot-4-ci).

Features:
	* Github template repository vs. Addon for simplicity
	* Web-export & GDScript focused for maximum jam
	* Premade basic UI for main menu, pause menu, settings, controls, and credits
	* UI transition animations with [simple-gui-transitions](https://github.com/murikistudio/simple-gui-transitions)
	* ATTRIBUTION.md for in-game credits (inspired by [Maaack](https://github.com/Maaack/Godot-Game-Template/blob/main/ATTRIBUTION.md)'s approach)
	* Addon management with [gd-plug](https://github.com/imjp94/gd-plug)
	* CI/CD adapted from [abarichello/godot-ci](https://github.com/abarichello/godot-ci)
	* ...

Don't just settle for the first template you find! Compare the alternatives and decide which best fits your desired features, coding style and approach to game development.

Alternatives:
	* [https://github.com/Maaack/Godot-Game-Template](https://github.com/Maaack/Godot-Game-Template)
	* [https://github.com/bitbrain/godot-gamejam](https://github.com/bitbrain/godot-gamejam)
	* [https://github.com/nezvers/Godot-GameTemplate](https://github.com/nezvers/Godot-GameTemplate)
	* [And many more...](https://godotengine.org/asset-library/asset?filter=template&category=&godot_version=&cost=&sort=updated)

## Initial setup

After cloning or templating the repo, it's necessary to install plugins. Plugins are managed with [gd-plug](https://github.com/imjp94/gd-plug). To install plugins from the Godot editor, the [gd-plug-ui](https://github.com/imjp94/gd-plug-ui) can be installed through the Asset Library. Or plugins can be installed with the command line below.
```
godot.exe -s plug.gd install
```
It's usually necessary to start Godot twice after installing plugins this way, once to build the import cache and a second time for plugins to load properly.

## Main

Once plugins are setup, open `res://main.tscn` and `res://main.gd` and create your game!

## Tests

[GUT](https://github.com/bitwes/Gut) is used for testing. The `tests/` folder contains the test code.

## CI/CD

[Github actions](https://docs.github.com/actions) are used to run the tests on every push to source control. The Github build environment is limited compared to the desktop Godot editor. Tests relying on the following features should use the [`skip_script` variable](https://gut.readthedocs.io/en/latest/New-For-Godot-4.html#what-s-new-changed-in-gut-9-0-0-for-godot-4-0) to avoid tests failing under CI.
* DisplayServer
* Input (depends on DisplayServer)

On succesful test and export, and if configured, the CI action uses [butler](https://itch.io/docs/butler/) to deploy the game to [itch.io](https://itch.io).  Setup these secrets in your Github repository to enable push:
	* ITCHIO_USERNAME
	* ITCHIO_GAME
	* BUTLER_API_KEY

