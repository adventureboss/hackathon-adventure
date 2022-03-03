tool
extends PanelContainer

class_name GameRoom

onready var game_state: GameState = get_node("/root/GameState")

func _ready():
	update()

func update():
	$MarginContainer/Rows/RoomName.text = get_room_name()
	$MarginContainer/Rows/RoomDescription.text = get_room_description()
	
func keyword(keyword: String):
	return "[url=%s][color=#cb1eca]%s[/color][/url]" % [keyword, keyword]
	
func get_room_name():
	return "Default room name"
	
func get_room_description():
	return "Default room description"
	

var exits: Dictionary = {}

func connect_exit(direction: String, room: GameRoom, is_locked: bool = false):
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
