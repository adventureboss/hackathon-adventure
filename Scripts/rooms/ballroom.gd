extends "res://Scripts/Room.gd"

func get_room_name():
	return "Ballroom"
	
func get_room_description():
	return "The gem of the entire conference. There is a large " + keyword("stage") + ", rows and rows of " + keyword("seats") + ", and a " + keyword("person") + " standing near a projector machine pulling at their hair."
