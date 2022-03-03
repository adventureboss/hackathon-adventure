extends "res://Scripts/actor.gd"

func look_at():
	return "What kind of person makes this kind of mess anyway? Not me, that’s for sure"

func pick_up():
	if game_state.has_item("beans"):
		return "I already have some beans!"
	
	game_state.add_item("beans")
	return "I’ll just take some of the evidence from the crime scene"
