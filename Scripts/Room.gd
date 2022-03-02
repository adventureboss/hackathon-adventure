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


func connect_exit_locked(direction: String, room):
	_connect_exit(direction, room, true)


func connect_exit_unlocked(direction: String, room):
	_connect_exit(direction, room, false)


func _connect_exit(direction: String, room: GameRoom, is_locked: bool = false):
	var exit = Exit.new()
	exit.room_1 = self
	exit.room_2 = room
	exit.exit_is_locked = is_locked
	exits[direction] = exit
	match direction:
		"west":
			room.exits["east"] = exit
		"east":
			room.exits["west"] = exit
		"north":
			room.exits["south"] = exit
		"south":
			room.exits["north"] = exit
		_:
			printerr("Tried to connect invalid direction: %s", direction)
