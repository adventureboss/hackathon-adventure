extends "res://Scripts/Room.gd"

func get_room_name():
	return "East Hall"
	
func get_room_description():
	return "The east hall is a fairly non-descript conference center hallway, adorned with " + keyword("banners") + " about the conference. There is a " + keyword("water fountain") + " and a somewhat elaborate " + keyword("coffee machine") + " nearby. To the north, you see a " + keyword("sign") + " indicating the vendor hall. To the south, is a " + keyword("session room") + " with a sign out front showing the " + keyword("schedule") + "."
