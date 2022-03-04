extends "res://Scripts/actor.gd"

func look_at():
	return "If you reset the " + keyword("router") + ", the default " + keyword("password") + " will show on the screen"


func pick_up():
	return "I better leave it here for the next person"
