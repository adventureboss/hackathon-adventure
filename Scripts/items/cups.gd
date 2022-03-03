extends "res://Scripts/actor.gd"

func look_at():
	return "It's just a cup"

func pick_up():
	if game_state.has_item("cup"):
		return "I already have a cup!"
	
	game_state.add_item("cup")
	return "Don't mind if I do"
