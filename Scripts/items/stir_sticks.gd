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
	#TODO: use on router
		
