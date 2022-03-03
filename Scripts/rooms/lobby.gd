extends "res://Scripts/Room.gd"

func get_room_name():
	return "Lobby"
	
func get_room_description():
	return "It's definitely a tech conference based on the sheer quantity of " + keyword("nerds") + " hanging around. You see velvet " + keyword("ropes") + " guiding attendees to the check-in desk. One " + keyword("associate") + " doesn't have a line. To the " + keyword("east") + " and " + keyword("west") + " are hallways leading deeper into the convention center."
