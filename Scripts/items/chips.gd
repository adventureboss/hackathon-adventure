extends "res://Scripts/actor.gd"

func use(item):
	return "Stale, but when has that ever stopped me"


func pick_up():
	if game_state.has_item("chips") == false:
		game_state.add_item("chips")
		return "Sure, why not"
	else:
		return "I already have chips"


func look_at():
	return "Grilled Cheese flavor. MMMMMM"
