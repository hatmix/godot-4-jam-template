extends Node

# What goes into globals.gd?
# If the function depends on the something in the game, it's a global.
# If it's independent, it (probably) belongs in utils.gd

## Use UI/MessageBox to display a status update message to the player
signal post_ui_message(text: String, icon: Message.ICON)

## Emitted by UI/Controls when a action is remapped
signal controls_changed(config: GUIDERemappingConfig)
