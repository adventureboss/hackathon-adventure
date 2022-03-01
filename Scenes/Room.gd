extends PanelContainer

class_name GameRoom

export (String) var room_name = "name"
export (String) var room_description = "description"
export (Dictionary) var talk_to_dictionary = {}

var exits: Dictionary = {}


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
