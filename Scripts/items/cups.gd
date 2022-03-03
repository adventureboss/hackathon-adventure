extends "res://Scripts/actor.gd"


func look_at():
	return "It's just a " + keyword("cup") + "."

func pick_up():
	if game_state.has_item("cup"):
		return "I already have a " + keyword("cup") + "!"
	
	game_state.add_item("cup")
	return "Don't mind if I do"
