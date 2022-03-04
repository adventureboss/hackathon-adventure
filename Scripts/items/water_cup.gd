extends "res://Scripts/actor.gd"

func look_at():
	return "It's a cup full of water"

func use(with):
	if with.name == "self":
		game_state.remove_item("water_cup")
		game_state.add_item("cup")
		return "Ahhh, that really hits the spot. Leaves a subtle cucumber flavor too."
	else:
		return "I don't want to waste it."
