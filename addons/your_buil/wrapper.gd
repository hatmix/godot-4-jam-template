class_name YourBuil
extends Object
## A wrapper for build data saved during export.
##
## This class is used to reference build data that is generated when
## exporting a project.
## It can [b]only[/b] be used in exported builds with the YourBuil plugin
## enabled. Otherwise its methods will return default values.
## [br][br]
## [YourBuil] should not be instantiated. Instead call its static members
## and methods like so:
## [codeblock]
## var my_str = YourBuil.git_branch + "-" + YourBuil.get_date_string()
## [/codeblock]

# Filename of the build data file available only in exported builds
const _BUILD_DATA_PATH := "res://addons/your_buil/temp.json"

## The [JSON] resource that this class is a wrapper for,
## or [code]null[/code] outside of exported builds.
## The file itself is created during export and deleted after export.
## [br][br]
## You can save copies using [method ResourceSaver.save]:
## [codeblock]
## ResourceSaver.save(YourBuil.json, "res://your_buil.json")
## [/codeblock]
static var json: JSON
## The current branch, or the empty string [code]""[/code]
## if the project is not in a git repository.
## [br][br]
## This is the result of running [code]git rev-parse --abbrev-ref HEAD[/code]
## in the project directory during export.
static var git_branch: String:
	get:
		_lazy_load_build_data()
		if json == null:
			return ""
		return json.data.git.branch
## The number of commits in the line from the initial commit to the
## last commit, or [code]0[/code] if the project is not in a git repository.
## [br][br]
## This is the result of running [code]git rev-list --count HEAD[/code]
## in the project directory during export.
static var git_commit_count: int:
	get:
		_lazy_load_build_data()
		if json == null:
			return 0
		return json.data.git.commit_count
## The hash of the last commit, or the empty string [code]""[/code]
## if the project is not in a git repository.
## This is 40 characters long. Use [method get_git_commit_hash] to shorten it.
## [br][br]
## This is the result of running [code]git rev-parse HEAD[/code]
## in the project directory during export.
static var git_commit_hash: String:
	get:
		_lazy_load_build_data()
		if json == null:
			return ""
		return json.data.git.commit_hash
## The tag of the last commit, or the empty string [code]""[/code]
## if it has no tag or if the project is not in a git repository.
## If the last commit has more than one tag, the tag will be determined
## following a deterministic process.
## [br][br]
## This is the result of running [code]git describe --exact-match --tags[/code]
## in the project directory during export.
static var git_tag: String:
	get:
		_lazy_load_build_data()
		if json == null:
			return ""
		return json.data.git.tag
## The year in UTC, or [code]1[/code] outside of exported builds.
## [br][br]
## This is obtained by calling
## [method Time.get_datetime_dict_from_system] during export.
static var year: int:
	get:
		_lazy_load_build_data()
		if json == null:
			return 1
		return json.data.time.year
## The month in UTC, or [code]1[/code] (January) outside of exported builds.
## [br][br]
## This is obtained by calling
## [method Time.get_datetime_dict_from_system] during export.
static var month: Time.Month:
	get:
		_lazy_load_build_data()
		if json == null:
			return 1
		return json.data.time.month
## The day in UTC, or [code]1[/code] outside of exported builds.
## [br][br]
## This is obtained by calling
## [method Time.get_datetime_dict_from_system] during export.
static var day: int:
	get:
		_lazy_load_build_data()
		if json == null:
			return 1
		return json.data.time.day
## The hour in UTC, or [code]0[/code] outside of exported builds.
## [br][br]
## This is obtained by calling
## [method Time.get_datetime_dict_from_system] during export.
static var hour: int:
	get:
		_lazy_load_build_data()
		if json == null:
			return 0
		return json.data.time.hour
## The minute in UTC, or [code]0[/code] outside of exported builds.
## [br][br]
## This is obtained by calling
## [method Time.get_datetime_dict_from_system] during export.
static var minute: int:
	get:
		_lazy_load_build_data()
		if json == null:
			return 0
		return json.data.time.minute
## The second in UTC, or [code]0[/code] outside of exported builds.
## [br][br]
## This is obtained by calling
## [method Time.get_datetime_dict_from_system] during export.
static var second: int:
	get:
		_lazy_load_build_data()
		if json == null:
			return 0
		return json.data.time.second


## Returns [code]true[/code] if build data was saved.
## That should be when the project was exported with the
## YourBuil plugin enabled.
static func has_data() -> bool:
	return json != null


## Returns [code]true[/code] if git build data was saved.
## That should be when the project was exported with the
## YourBuil plugin enabled and within a git repository.
static func has_git_data() -> bool:
	return not git_commit_hash.is_empty()


## Returns [code]true[/code] if the last commit was tagged.
## This is equivalent to [code]YourBuil.git_tag != ""[/code].
static func has_git_tag() -> bool:
	return git_tag != ""


## Returns [member git_commit_hash] shortened to the first
## [param length] characters,
## or returns the empty string [code]""[/code] if the project is not
## in a git repository.
static func get_git_commit_hash(length: int = 40) -> String:
	if not has_git_data:
		return ""
	return git_commit_hash.substr(0, length)


## Arranges [member year], [member month], and [member day] to
## the format YYYY-MM-DD.
static func get_date_string() -> String:
	var padded_year := str(year).pad_zeros(4)
	var padded_month := str(month).pad_zeros(2)
	var padded_day := str(day).pad_zeros(2)
	return padded_year + "-" + padded_month + "-" + padded_day


## Arranges [member hour], [member minute], and [member second] to
## the format hh:mm:ss.
static func get_time_string() -> String:
	var padded_hour := str(hour).pad_zeros(2)
	var padded_minute := str(minute).pad_zeros(2)
	var padded_second := str(second).pad_zeros(2)
	return padded_hour + ":" + padded_minute + ":" + padded_second


static func _lazy_load_build_data() -> void:
	if json != null:
		return
	if not ResourceLoader.exists(_BUILD_DATA_PATH):
		return
	json = load(_BUILD_DATA_PATH)
