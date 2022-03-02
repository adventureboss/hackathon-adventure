extends "res://Scripts/actor.gd"

func look_at():
	if game_state.has_item("pamphlet"):
		return "Introducing the new [something]"
		
	return "There is a pamphlet on every chair"
	
func pick_up():
	game_state.add_item("pamphlet")
	return "<Pamphlet added to your inventory>"
