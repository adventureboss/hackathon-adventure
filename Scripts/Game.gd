extends Control


const InputResponse = preload("res://Scenes/InputResponse.tscn")

var max_scroll_length := 0

onready var user_cli = $Background/MarginContainer/Rows/InputArea/HBoxContainer/Input
onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/GameInfo/ScrollContainer
onready var scrollbar = scroll.get_v_scrollbar()


func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value

func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = scrollbar.max_value


func _on_Input_text_entered(new_text: String) -> void:
	var input_response = InputResponse.instance()
	input_response.set_text(new_text, "This is where a response would go.")
	history_rows.add_child(input_response)


func _on_TalkToButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "TALK TO "


func _on_GiveButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "GIVE "


func _on_UseButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "USE "


func _on_WalkButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "WALK "


func _on_PickUpButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "PICK UP "


func _on_LookAtButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "LOOK AT "
