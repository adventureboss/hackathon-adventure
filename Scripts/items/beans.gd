extends "res://Scripts/actor.gd"

func look_at():
	if game_state.has_item("beans"):
		return "Beans, beans, good for your heart..."
	else:
		return "What kind of person makes this kind of mess anyway? Not me, that’s for sure"

func pick_up():
	if game_state.has_item("beans"):
		return "I already have some " + keyword("beans") + "!"
	
	game_state.add_item("beans")
	return "I’ll just take some of the evidence from the crime scene"

func use(with):
	if with.name == "self":
		game_state.set_dialog_state("player", "caffeinated", 2)
		return "I'll just chew these up. Blech! Tastes like sand and fingernail polish. Oh look! I can see between atoms."
	if with.name == "cat":
		return "I don't think he'll eat them raw."
