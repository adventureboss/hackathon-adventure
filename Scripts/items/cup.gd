extends "res://Scripts/actor.gd"

func look_at():
	return "It's just a cup"

func pick_up():
	return "I already have it!"

func use(with):
	match with.name:
		"coffee_machine":
			with.talk_to()
			return ""
		"water_fountain":
			if game_state.has_item("water_cup"):
				return "I already have a cup of water."
			game_state.remove_item("cup")
			game_state.add_item("water_cup")
			return "Great! now I have a water cup"
		"beans":
			if game_state.has_item("beans_cup"):
				return "I already have a cup of beans."
			else:
				game_state.remove_item("cup")
				game_state.add_item("beans_cup")
				return "Great! Now I have a cup of beans."
			
	return "I can't do that"
			
