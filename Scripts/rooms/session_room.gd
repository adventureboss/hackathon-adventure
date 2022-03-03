extends "res://Scripts/Room.gd"

func get_room_name():
	return "Session Room"
	
func get_room_description():
	return "Tired attendees come here to listen to someone drone while they catch a quick nap. The " + keyword("room") + " is empty right now aside from a few napping " + keyword("nerds") + " and a lonely " + keyword("podium") + "."
