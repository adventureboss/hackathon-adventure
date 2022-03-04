extends "res://Scripts/Room.gd"

func get_room_name():
	return "East Hall"
	
func get_room_description(): 
	if game_state.get_dialog_state("coffee_machine", "broken") and game_state.get_dialog_state("cat", "sleeping") == 1:
		return "The east hall is a fairly non-descript conference center hallway, adorned with " + keyword("banners") + " about the conference. There is a " + keyword("water fountain") + " and a completely annihilated " + keyword("coffee machine") + " with " + keyword("beans") + " spilling all over the floor. To the north, you see a " + keyword("sign") + " indicating the vendor hall. To the south, is a " + keyword("session room") + " with a sign out front showing the " + keyword("schedule") + ". There's also a sleeping " + keyword("cat") + " on the floor near the water fountain. He's cute."	
	elif game_state.get_dialog_state("coffee_machine", "broken"):
		return "The east hall is a fairly non-descript conference center hallway, adorned with " + keyword("banners") + " about the conference. There is a " + keyword("water fountain") + " and a completely annihilated " + keyword("coffee machine") + " with " + keyword("beans") + " spilling all over the floor. To the north, you see a " + keyword("sign") + " indicating the vendor hall. To the south, is a " + keyword("session room") + " with a sign out front showing the " + keyword("schedule") + ". There's also a " + keyword("cat") + " on the floor near the water fountain. He's cute."
	elif game_state.get_dialog_state("cat", "sleeping") == 1:
		return "The east hall is a fairly non-descript conference center hallway, adorned with " + keyword("banners") + " about the conference. There is a " + keyword("water fountain") + " and a somewhat elaborate " + keyword("coffee machine") + " nearby. To the north, you see a " + keyword("sign") + " indicating the vendor hall. To the south, is a " + keyword("session room") + " with a sign out front showing the " + keyword("schedule") + ". There's also a sleeping " + keyword("cat") + " on the floor near the water fountain. He's cute."	
	else:
		return "The east hall is a fairly non-descript conference center hallway, adorned with " + keyword("banners") + " about the conference. There is a " + keyword("water fountain") + " and a somewhat elaborate " + keyword("coffee machine") + " nearby. To the north, you see a " + keyword("sign") + " indicating the vendor hall. To the south, is a " + keyword("session room") + " with a sign out front showing the " + keyword("schedule") + ". There's also a " + keyword("cat") + " on the floor near the water fountain. He's cute."
