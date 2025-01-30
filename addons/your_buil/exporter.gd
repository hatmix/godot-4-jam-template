extends EditorExportPlugin


func _get_name() -> String:
	return "YourBuil_DataExporter"


func _export_begin(
	features: PackedStringArray,
	is_debug: bool,
	path: String,
	flags: int
) -> void:
	# Populate data dictionary
	var data: Dictionary
	var git_data: Dictionary
	git_data["branch"] = _get_git_branch()
	git_data["commit_count"] = _get_git_commit_count()
	git_data["commit_hash"] = _get_git_commit_hash()
	git_data["tag"] = _get_git_tag()
	data["git"] = git_data
	var time_data := Time.get_datetime_dict_from_system(true)
	time_data.erase("weekday")
	time_data.erase("dst")
	data["time"] = time_data

	# Save build data as a json file
	var json_string := JSON.stringify(data, "\t")
	var json := JSON.new()
	json.parse(json_string)
	var error := ResourceSaver.save(json, YourBuil._BUILD_DATA_PATH)
	if error != OK:
		push_error("YourBuil Error: %s. Failed to save temporary build data file."
				% error_string(error))


func _export_end() -> void:
	# Delete the build data file so that it's only around in exported builds
	var error := DirAccess.remove_absolute(YourBuil._BUILD_DATA_PATH)
	if error != OK:
		push_warning("YourBuil Warning: %s. Failed to remove temporary build data file."
				% error_string(error))


func _get_git_branch() -> String:
	var output: Array = []
	OS.execute("git", PackedStringArray(["rev-parse", "--abbrev-ref", "HEAD"]), output)
	if output.is_empty() or output[0].is_empty():
		return ""
	return output[0].trim_suffix("\n")


func _get_git_commit_count() -> int:
	var output: Array = []
	OS.execute("git", PackedStringArray(["rev-list", "--count", "HEAD"]), output)
	if output.is_empty() or output[0].is_empty():
		return 0
	return output[0].trim_suffix("\n").to_int()


func _get_git_commit_hash() -> String:
	var output: Array = []
	OS.execute("git", PackedStringArray(["rev-parse", "HEAD"]), output)
	if output.is_empty() or output[0].is_empty():
		return ""
	return output[0].trim_suffix("\n")


func _get_git_tag() -> String:
	var output: Array = []
	OS.execute("git", PackedStringArray(["describe", "--exact-match", "--tags"]), output)
	if output.is_empty() or output[0].is_empty():
		return ""
	return output[0].trim_suffix("\n")
