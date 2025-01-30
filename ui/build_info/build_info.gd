extends GridContainer

# The deploy action will create this file if it doesn't exist with the command
# "git rev-list --count HEAD > version.txt", or you can maintain it manually and
# check into source control. If you change the filename, be sure to update the
# export configurations to include your new file.
const VERSION_FILE: String = "res://version.txt"

@onready var build_value: Label = $BuildValue


func _ready() -> void:
	var version: String = FileAccess.get_file_as_string(VERSION_FILE)
	if version:
		build_value.text = version
	else:
		self.hide()
