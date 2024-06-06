extends Node

const FILE: String = "user://settings.cfg"
const DEFAULT_FILE: String = "res://default_settings.cfg"

enum SECTION {AUDIO}

static var _settings: ConfigFile
# Timer is used to prevent fast repeated saving of cfg file
var timer: Timer


func load_settings() -> void:
	if _settings != null:
		return
	_init_timer()
	_settings = ConfigFile.new()
	var err: int = _settings.load(FILE)
	if err:
		print("Loading settings from defaults")
		err = _settings.load(DEFAULT_FILE)
		if not err:
			err = _settings.save(FILE)


func _init_timer() -> void:
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(save_settings)
	add_child(timer)


func save_settings() -> void:
	print("saving settings")
	_settings.save(FILE)


func get_value(section: SECTION, key: String, default: Variant) -> Variant:
	load_settings()
	var section_name: String = SECTION.keys()[section]
	return _settings.get_value(section_name.to_pascal_case(), key, default)


func set_value(section: SECTION, key: String, value: Variant) -> void:
	load_settings()
	var section_name: String = SECTION.keys()[section]
	_settings.set_value(section_name.to_pascal_case(), key, value)
	timer.start(1.0)
