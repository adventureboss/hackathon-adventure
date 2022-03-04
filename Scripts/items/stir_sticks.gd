extends "res://Scripts/actor.gd"

func pick_up():
	if game_state.has_item("stir_stick"):
		return "I already have a stir stick."
	
	game_state.add_item("stir_stick")
	return "Good! Now I can stir stuff. Too bad there’s no cream or sugar"
	

func look_at():
	return "It’s a stir stick. I don’t see any cream or sugar though"

func use(with):
	if with.name == "self":
		return "I wonder how far I can get this up my nose? Ouch! Not far."
	elif with.name == "button":
		game_state.add_item("password")
		return PoolStringArray([
			"Aha! I pressed it. it must be resetting.  It says the " + keyword("password") + " is 'PowerBacon'.  Now I'm hungry.",
			"<Password added to your inventory>"
		]).join("\n")
	else:
		return "That won't work"
		
