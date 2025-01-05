# Godot UI Sound Controller
For Godot 4.2

This script and autoload automatically attaches sounds to buttons, tab bars, sliders, and line edits.

[Example on itch.io](https://maaack.itch.io/godot-game-template)  
_Example is of [Maaack's Game Template](https://github.com/Maaack/Godot-Game-Template), which includes additional features._

## Use Case
For adding SFX to all your project's UI elements from one node.


## Features

* Centralizes control of SFX for buttons, tab bars, sliders, and line edits.
* Automatically detects supported UI nodes added to scenes, and attaches sounds.
* Works as a script attached to a node in a scene, or as the project's autoload.


### How it Works
- The `UISoundController` node automatically attaches sounds to buttons, tab bars, sliders, and line edits in the scene. `ProjectUISoundController.tscn` is an autload used to apply UI sounds project-wide.
  
## Installation

### Godot Asset Library
This package is available as a plugin, meaning it can be added to an existing project. 

![Package Icon](/addons/maaacks_ui_sound_controller/media/UISoundController-Icon-black-transparent-256x256.png)  

When editing an existing project:

1.  Go to the `AssetLib` tab.
2.  Search for "Maaack's UI Sound Controller".
3.  Click on the result to open the plugin details.
4.  Click to Download.
5.  Check that contents are getting installed to `addons/` and there are no conflicts.
6.  Click to Install.
7.  Reload the project (you may see errors before you do this).
8.  Enable the plugin from the Project Settings > Plugins tab.


### GitHub


1.  Download the latest release version from [GitHub](https://github.com/Maaack/Godot-UI-Sound-Controller/releases/latest).  
2.  Extract the contents of the archive.
3.  Move the `addons/maaacks_ui_sound_controller` folder into your project's `addons/` folder.  
4.  Open/Reload the project.  
5.  Enable the plugin from the Project Settings > Plugins tab.  

#### Extras

Users that want additional features can try [Maaack's Game Template](https://github.com/Maaack/Godot-Game-Template).  

## Usage

Attach the `UISoundController.gd` script to a node that is in your UI scene, under the root node. Select the node, and assign your audio streams to the various supported UI events.

Alternatively, open `ProjectUISoundController.tscn`, select the root node, and assign audio streams to UI events project-wide.

## Links
[Attribution](ATTRIBUTION.md)  
[License](LICENSE.txt)  

