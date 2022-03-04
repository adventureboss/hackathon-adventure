extends "res://Scripts/Room.gd"

func get_room_name():
	return "Vendor Hall"
	
func get_room_description():
	return "The vendor hall is an enormous room filled with different vendors trying to pitch their wares to people who just want their " + keyword("t-shirt") + "s. From the entrance, you're able to see a " + keyword("vendor") + " promoting some kind of widget, and a " + keyword("robot") + ". The " + keyword("robot") + " seems to be promoting...something. Of course, there is also " + keyword("swag") +  "."
