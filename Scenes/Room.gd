tool
extends PanelContainer

class_name GameRoom

export (String) var room_name = "name" setget set_room_name
export (String, MULTILINE) var room_description = "description" setget set_room_description
export (Dictionary) var talk_to_dictionary = {}

var exits: Dictionary = {}


func set_room_name(new_name: String):
	$MarginContainer/Rows/RoomName.text = new_name
	room_name = new_name


func set_room_description(new_description: String):
	$MarginContainer/Rows/RoomDescription.text = new_description
	room_description = new_description


func connect_exit(direction: String, room: GameRoom):
	match direction:
		"west":
			exits[direction] = room
			room.exits["east"] = self
		"east":
			exits[direction] = room
			room.exits["west"] = self
		"north":
			exits[direction] = room
			room.exits["south"] = self
		"south":
			exits[direction] = room
			room.exits["north"] = self
		_:
			printerr("Tried to connect invalid direction: %s", direction)
