extends Control

const Response = preload("res://Scenes/Response.tscn")
const InputResponse = preload("res://Scenes/InputResponse.tscn")

export (int) var max_lines_remembered := 20

var max_scroll_length := 0
var button_carot_position := 10

onready var command_processor = $CommandProcessor
onready var room_manager = $RoomManager
onready var user_cli = $Background/MarginContainer/Rows/InputArea/HBoxContainer/Input
onready var game_info = $Background/MarginContainer/Rows/GameInfo
onready var history_rows = $Background/MarginContainer/Rows/GameInfo/MarginContainer/ScrollContainer/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/GameInfo/MarginContainer/ScrollContainer
onready var scrollbar = scroll.get_v_scrollbar()

onready var rows = $Background/MarginContainer/Rows
onready var input_area = $Background/MarginContainer/Rows/InputArea/HBoxContainer/Input
onready var inventory_list = $Background/MarginContainer/Rows/HBoxContainer/Inventory/VBoxContainer/InventoryList

onready var game_state = get_node("/root/GameState")

var input_status_enabled: bool = true


func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	game_state.connect("keyword_clicked", self, "on_keyword_pressed")
	inventory_list.connect("item_selected", self, "on_item_clicked")
	max_scroll_length = scrollbar.max_value

	game_state.connect("show_dialogue", self, "show_dialogue")
	game_state.connect("items_updated", self, "update_items")
	game_state.connect("room_changed_programatically", self, "on_change_to_room_programatically")
	var starting_room_response = command_processor.initialize(room_manager.get_child(0))
	create_response(starting_room_response)
	update_items(game_state.get_items())
	
	game_state.rooms = []
	for room in room_manager.get_children():
		game_state.rooms.append(room)


func create_response(response_text):
	var response = Response.instance()
	response.text = response_text
	add_response_to_game(response)


func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = scrollbar.max_value

func show_dialogue(resource: DialogueResource, title: String) -> void:
	self.set_input_status(false)
	scroll.hide()
	var dialogue = yield(DialogueManager.get_next_dialogue_line(title, resource), "completed")
	if dialogue != null:
		var node = preload("res://Scenes/Dialogue.tscn").instance()
		node.dialogue = dialogue
		game_info.add_child(node)
		show_dialogue(resource, yield(node, "actioned"))
	else:
		self.set_input_status(true)
		scroll.show()
	user_cli.grab_focus()
	user_cli.caret_position = 0

func update_items(items) -> void:
	inventory_list.clear()
	for item in items:
		inventory_list.add_item(item.display_name)


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

	var response = command_processor.process_command(new_text)
	if response != null:
		var input_response = InputResponse.instance()
		input_response.set_text(new_text, response)
		add_response_to_game(input_response)

func on_change_to_room_programatically(room, command = "") -> void:
	var input_response = InputResponse.instance()
	input_response.set_text(command, room.look())
	add_response_to_game(input_response)
	update_items(game_state.get_items())

func _on_TalkToButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "TALK TO "
	user_cli.caret_position = button_carot_position


func _on_GiveButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "GIVE "
	user_cli.caret_position = button_carot_position


func _on_UseButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "USE "
	user_cli.caret_position = button_carot_position


func _on_WalkButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "WALK "
	user_cli.caret_position = button_carot_position


func _on_PickUpButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "PICK UP "
	user_cli.caret_position = button_carot_position


func _on_LookAtButton_pressed() -> void:
	user_cli.clear()
	user_cli.text += "LOOK AT "
	user_cli.caret_position = button_carot_position
	
func _on_WalkNorthButton_pressed() -> void:
	_on_Input_text_entered("WALK NORTH")


func _on_WalkEastButton_pressed() -> void:
	_on_Input_text_entered("WALK EAST")


func _on_WalkWestButton_pressed() -> void:
	_on_Input_text_entered("WALK WEST")


func _on_WalkSouthButton_pressed() -> void:
	_on_Input_text_entered("WALK SOUTH")


func on_keyword_pressed(keyword):
	if not user_cli.text.ends_with(" "):
		user_cli.text += " "
	user_cli.text += keyword
	user_cli.grab_focus()
	user_cli.caret_position = user_cli.text.length()
	
func on_item_clicked(item_idx):
	var keyword = game_state.get_items()[item_idx].name.replace("_", " ")
	game_state.emit_signal("keyword_clicked", keyword)
	inventory_list.unselect_all()
