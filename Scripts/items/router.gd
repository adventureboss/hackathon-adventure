extends "res://Scripts/actor.gd"

func look_at():
	return "It's a " + keyword("router") + "! There are some flashing lights, a small screen, and a hole for the reset " + keyword("button") + "."


func pick_up():
	return "Hey there's a " + keyword("note") + " under this."
