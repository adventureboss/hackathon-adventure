extends "res://Scripts/Room.gd"

func get_room_name():
	return "Entrance"
	
func get_room_description():
	return "You have arrived at the " + keyword("doors") + " of Purple Cap Con! A gathering of technology enthusiasts from all over to learn about the latest and greatest open source achievements. The conference center doors are in front of you to the North. " + keyword("Nerds") + " are piling in to see what your favorite open source company has to show this time. You can tell by the panicked faces on some " + keyword('associates') + " that things aren't going quite as well as expected. Maybe you should ask around?"
