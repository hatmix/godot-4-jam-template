# Godot 4 Jam Template

A quick-start template for game jams. See the plain template in action at [https://hatmix.itch.io/godot-4-jam-template](https://hatmix.itch.io/godot-4-jam-template) (password `hatmix`).

Features:
* Web, Windows, Linux and macOS exports configured for maximum jam
* Github workflows for automatic uploads to Itch.io
* Premade basic UI for main menu, pause menu, credits, settings, and remapping controls
* [G.U.I.D.E](https://godotneers.github.io/G.U.I.D.E/) for input and input prompts
* Settings persisted across sessions (where `user://` filesystem is writable)
* Full keyboard and controller support for all template UI
* ATTRIBUTION.md for in-game credits (inspired by [Maaack](https://github.com/Maaack/Godot-Game-Template/blob/main/ATTRIBUTION.md)'s approach)
* [TODO Manager](https://github.com/OrigamiDev-Pete/TODO_Manager) included and todos added for setting up a new project

Don't just settle for the first template you find! This template was inspired by many other examples created by the Godot community.  Compare the alternatives and decide which best fits your desired feature set, coding style, and approach to game development.

Alternatives:
* [https://github.com/Maaack/Godot-Game-Template](https://github.com/Maaack/Godot-Game-Template)
* [https://github.com/bitbrain/godot-gamejam](https://github.com/bitbrain/godot-gamejam)
* [https://github.com/nezvers/Godot-GameTemplate](https://github.com/nezvers/Godot-GameTemplate)
* [And many more...](https://godotengine.org/asset-library/asset?filter=template&category=&godot_version=&cost=&sort=updated)

This template is intended to be used at project start. While it is possible to apply updates made to the template to projects created from earlier versions of the template, it is not designed for that. Other templates may be easier to upgrade or add to an existing project.

## Getting started

There are a few ways to get started.
* The "Use this template" link in Github
* Clone the repository
* Download a zip file of the source

Once the Godot project files are saved locally, open `res://main.tscn` and `res://main.gd` and create your game!

## Folder structure

`res://autoloads/` contains scripts added to the Godot project's globals/autoloads. (See section [Settings Persistence](#settings-persistence))

`res://exports/` has folders for each pre-configured export platform

`res://input/` contains a default G.U.I.D.E action and context mapping. (See [G.U.I.D.E documentation](https://godotneers.github.io/G.U.I.D.E/) for how to add new actions, etc.)

`res://media/` is intended for screenshots and other items used for documentation or the Itch.io page for the project. (See section [Publishing on Itch.io](#publishing-on-itch-io))

`res://test/` holds automated test scripts.

`res://ui/` is where most of the template's work is done (See section [UI](#ui)).

`res://ui/game/` is intended for the game UI/HUD and what comes with the template should be replaced when building your project.

I recommend creating a `res://game` directory to hold the scenes for gameplay. It's up to your preference and the type of project whether the separation of `res://ui/game` and `res://game` makes sense.

## UI

The main UI scene treats its direct children extended from UiPage as components to show or hide. They might be an entire screen or just a widget in the corner. The main UI scene includes basic UI for all of the template's menus, a stub in-game UI with pause screen, and Maaack's [`ProjectUISoundController`](https://github.com/Maaack/Godot-UI-Sound-Controller).

Main UI components are contained in directories under `res://ui`. The `assets` folder is for non-scene/non-code files used in the UI. The `game` folder and its scene are intended for the UI (HUD) shown during gameplay.
```
└───ui
	├───assets
	│   ├───audio
	│   ├───fonts
	│   └───icons
	│       └───notifications
	├───build_info
	├───controls
	├───credits
	├───game
	├───how_to_play
	├───main_menu
	├───notifications
	├───pause_menu
	└───settings
```

The intended approach is to keep all UI in `res://ui/ui.tscn` and instantiate it as a child of every other scene. This is to allow settings and controls to be called from the pause menu.

The top-level UI is set `PROCESS_MODE_ALWAYS` with children inheriting the mode. The `InGameMenuOverlay` will appear when `get_tree().paused == true`. In games where pausing the tree should not hide the game area, either remove that node or have the `PauseMenu` show and hide the overaly.

The project default theme is `res://ui/ui_theme.tres` generated by [ThemeGen](https://github.com/Inspiaaa/ThemeGen) and `res://ui/ui_theme.gd`.

## UI Navigation

The template UI is designed to work with keyboard, controller, and touch input as well as mouse. `Tab` and `shift+tab` move focus. Any controller input will grab focus except where this is prevented with `UiPage.prevent_joypad_focus_capture` which is used by the game ui page.

## Settings Persistence

Settings are saved in `user://settings.cfg` and control mappings in `user://controls.tres`. Saving and loading are handled by `res://autoloads/settings.gd`.

The input icons are generated by G.U.I.D.E in a RichTextLabel. The buttons used for remapping use the theme generated by `res://ui/controls/remap_input_button_theme.gd`.

## _Todo_ and _Fixme_ comments

Stay organized with TODO and FIXME comments in scripts and markdown files. Add your own special comments per [TODO Manager](https://github.com/OrigamiDev-Pete/TODO_Manager)'s documentation.

## Tests

[gdUnit4](https://github.com/MikeSchulze/gdUnit4) is used for testing.

## Github Workflows (CI/CD)

Don't struggle to export games in the last hour before the submission deadline! Use Github workflows to do all of that for you!

The template includes [Github actions](https://docs.github.com/actions) for running tests and optionally deploying to itch.io. The tests workflow runs on every push to every branch. Deploy runs after successful test runs on the main branch.

On succesful export, and if configured, the deploy workflow uses [butler](https://itch.io/docs/butler/) to deploy the game to [itch.io](https://itch.io).  Setup these secrets in your Github repository to enable push:
* ITCHIO_USERNAME
* ITCHIO_GAME
* BUTLER_API_KEY

Note that for butler uploads to work, the game page must already be created on Itch.io with one file manually uploaded. After that, butler can perform all the updates. (See [butler's documentation](https://itch.io/docs/butler/))

The file `res://version.txt` is used as a version or build identifier in the main menu. This file is generated by the deploy workflow if not already present in source control. Automatic versioning is based on number of git commits. You can maintain the `res://version.txt` manually whether using source control or not. See the files at `res://ui/build_info/`.

## Publishing on Itch.io

Publishing your game on Itch.io is not the end of your jam journey! A good looking game page will create a strong first impression before your game is played. Jannik Boysen's Easy-Releasy .png templates are included in the `media` folder to simplify making a great looking page for your game.
