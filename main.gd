extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("https://itch.io/api/1/me/me", ["mode: no-cors"])
	GuiTransitions.go_to("MainMenu")

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var response_json = JSON.parse_string(body.get_string_from_utf8())
	print(response_json)

