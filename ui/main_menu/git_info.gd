extends GridContainer

@onready var build_value: Label = $BuildValue


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tag: String = YourBuil.git_tag
	var count: int = YourBuil.git_commit_count
	var hash: String = YourBuil.git_commit_hash
	if tag:
		build_value.text = tag
	elif count:
		build_value.text = str(count)
		if hash:
			build_value.text += ".%s" % hash.right(6)
	else:
		self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
