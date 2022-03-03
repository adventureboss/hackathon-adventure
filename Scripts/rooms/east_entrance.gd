extends "res://Scripts/Room.gd"

func get_room_name():
	return "East Checkpoint"
	
func get_room_description():
	return "A " + keyword("guard") + "stands by checking badges. He's a big guy. He could probably pick you up with one hand if you start any shenanigans. Beyond the " + keyword('guard') + " is a " + keyword("hallway") + " leading deeper into the convention center."
