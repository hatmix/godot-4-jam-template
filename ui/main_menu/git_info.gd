extends GridContainer

@onready var build_value: Label = $BuildValue


func _ready() -> void:
	# Just hide until a versioning system is in place
	# Not sure why YourBuil doesn't work in the container, but it doesn't
	self.hide()
