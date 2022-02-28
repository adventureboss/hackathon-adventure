extends Control


const InputResponse = preload("res://Scenes/InputResponse.tscn")

onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/GameInfo/ScrollContainer
onready var scrollbar = scroll.get_v_scrollbar()


func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")


func handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value


func _on_Input_text_entered(new_text: String) -> void:
	var input_response = InputResponse.instance()
	input_response.set_text(new_text, "This is where a response would go.")
	history_rows.add_child(input_response)
