extends Control

const Response = preload("res://Scenes/Response.tscn")
const InputResponse = preload("res://Scenes/InputResponse.tscn")

export (int) var max_lines_remembered := 20

var max_scroll_length := 0

onready var command_processor = $CommandProcessor
onready var user_cli = $Background/MarginContainer/Rows/InputArea/HBoxContainer/Input
onready var game_info = $Background/MarginContainer/Rows/GameInfo
onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/GameInfo/ScrollContainer
onready var scrollbar = scroll.get_v_scrollbar()

onready var rows = $Background/MarginContainer/Rows
onready var input_area = $Background/MarginContainer/Rows/InputArea/HBoxContainer/Input
onready var bottom_area = $Background/MarginContainer/Rows/BottomArea

var input_status_enabled: bool = true
var dialog_resource

func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	var starting_message = Response.instance()
	starting_message.text = "You have arrived at Purple Beret Con! A gathering of nerds from all over to learn about the latest and greatest open source achievements. The conference center doors are in front of you to the North. Nerds are piling in to see what your favorite open source company has to show this time. You can tell by the panicked faces on some associates that things aren't going quite as well as expected. Maybe you should ask around? The Lobby is ahead of you to the North."
	
	# main room dialog?
	dialog_resource = preload("res://Dialogs/associate.tres")
	command_processor.connect("show_dialogue", self, "show_dialogue")
	
	add_response_to_game(starting_message)

func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = scrollbar.max_value

func show_dialogue(title: String) -> void:
	self.set_input_status(false)
	scroll.hide()
	var dialogue = yield(DialogueManager.get_next_dialogue_line(title, dialog_resource), "completed")
	if dialogue != null:
		var node = preload("res://Scenes/Dialogue.tscn").instance()
		node.dialogue = dialogue
		game_info.add_child(node)
		show_dialogue(yield(node, "actioned"))
	else:
		self.set_input_status(true)
		scroll.show()

func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()


func add_response_to_game(response: Control):
	history_rows.add_child(response)
	delete_history_beyond_limit()


func set_input_status(is_enabled: bool):
	input_status_enabled = is_enabled
	if (is_enabled):
		input_area.show()
	else:
		input_area.hide()
	
func _on_Input_text_entered(new_text: String) -> void:
	if new_text.empty():
		return

	var input_response = InputResponse.instance()
	var response = command_processor.process_command(new_text)
	print("RESPONSE: ", response)
	input_response.set_text(new_text, response)
	add_response_to_game(input_response)


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
	
