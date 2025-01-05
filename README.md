# Godot 4 Jam Template

Quick start template for game jams built on [hatmix/godot-4-ci](https://github.com/hatmix/godot-4-ci). See the plain template in action at [https://hatmix.itch.io/godot-4-jam-template](https://hatmix.itch.io/godot-4-jam-template) (try password `gwj70`).

Features:
* Github template repository vs. addon
* Web, Windows, Linux and macOS exports for maximum jam
* Premade basic UI for main menu, pause menu, credits, and settings
* Visualization of controls with built-in remapping
* Settings persisted across sesssions (where `user://` filesystem is writable)
* Keyboard and controller support for all template UI, touchscreen via [Godot's emulate mouse from touch setting](https://docs.godotengine.org/en/stable/classes/class_projectsettings.html#class-projectsettings-property-input-devices-pointing-emulate-mouse-from-touch)
* UI transition animations with [Simple GUI Transitions](https://github.com/murikistudio/simple-gui-transitions)
* ATTRIBUTION.md for in-game credits (inspired by [Maaack](https://github.com/Maaack/Godot-Game-Template/blob/main/ATTRIBUTION.md)'s approach)
* CI/CD for automatic Itch.io updates adapted from [abarichello/godot-ci](https://github.com/abarichello/godot-ci)

Don't just settle for the first template you find! Compare the alternatives and decide which best fits your desired feature set, coding style, and approach to game development.

Alternatives:
* [https://github.com/Maaack/Godot-Game-Template](https://github.com/Maaack/Godot-Game-Template)
* [https://github.com/bitbrain/godot-gamejam](https://github.com/bitbrain/godot-gamejam)
* [https://github.com/nezvers/Godot-GameTemplate](https://github.com/nezvers/Godot-GameTemplate)
* [And many more...](https://godotengine.org/asset-library/asset?filter=template&category=&godot_version=&cost=&sort=updated)

## Initial setup

There are a few ways to get started.
    * "Use this template"
    * Clone the repository
    * Download a zip file of the source

## Main

Once the Godot project files are cloned locally, open `res://main.tscn` and `res://main.gd` and create your game!

## UI

Most of this template's work is done in the UI scenes under `res://ui/...`. The [Simple GUI Transitions](https://github.com/murikistudio/simple-gui-transitions) addon uses a "layout" concept for showing and hiding UI elements. A layout might be an entire screen or just a widget in the corner. The main UI scene includes the layouts for all of the template's menus, a skeleton in-game UI, and Maaack's [`ProjectUISoundController`](https://github.com/Maaack/Godot-UI-Sound-Controller).

The intended approach is to keep all UI in `res://ui/ui.tscn` and instantiate it as a child of every other scene. This is just preference and it could be changed any number of ways. Simple GUI Transitions will discover its layouts wherever they are in the scene tree. It's also extremely flexible and much more could be done with its features.

The top-level UI is set `PROCESS_MODE_ALWAYS` with children inheriting the mode. The `InGameMenuOverlay` will appear when `get_tree().paused == true`. In games where pausing the tree should not hide the game area, either remove that node or have the `PauseMenu` show and hide the overaly.

## Folder structure

Each UI layout is contained in its own directory under `res://ui`. The `assets` folder is for non-scene/non-code files used in the UI. The `game` folder and its scene are intended for the UI (HUD) shown in gameplay only and I recommend creating a `res://game` directory to hold other game files. 
```
├───autoloads
├───tests
└───ui
    ├───assets
    │   ├───audio
    │   ├───fonts
    │   └───icons
    │       ├───input_devices
    │       └───notifications
    ├───controls
    ├───credits
    ├───game
    ├───main_menu
    ├───notifications
    ├───pause_menu
    └───settings
```

## Settings and Controls

Actions not starting with "ui_" or "editor_" will be listed in the controls UI. If there are no actions defined, a default set of ui_ actions will be shown. The default set is just for testing and changes to those actions will not persist.

Settings are saved automatically in `user://settings.cfg` and control mappings in `user://controls.tres`. Saving and loading are handled by `res://autoloads/settings.gd`.

## Tests

GUT testing has been removed. I hope to have [gdUnit4](https://github.com/MikeSchulze/gdUnit4) tests working with CI soon.

## CI/CD

[Github actions](https://docs.github.com/actions) can be used to publish to itch.io on every push.

On succesful export, and if configured, the CI action uses [butler](https://itch.io/docs/butler/) to deploy the game to [itch.io](https://itch.io).  Setup these secrets in your Github repository to enable push:
* ITCHIO_USERNAME
* ITCHIO_GAME
* BUTLER_API_KEY
