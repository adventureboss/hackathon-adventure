extends "res://Scripts/actor.gd"

const dialog = preload("res://Dialogs/event_coordinator.tres")

func pick_up():
	if game_state.has_item("floppy"):
		return "I already have the " + keyword("floppy") + " disk."
	
	if game_state.get_dialog_state("cat", "complete") == true:
		game_state.add_item("floppy")
		return "Got it! It says, “Presentation files. Definitely don’t lose or let a cat sit on it. Should be fine"
	
	if game_state.get_dialog_state("cat", "sleeping") == 1:
		return "I can't pick it up. The cat is on top of it"
	
	return "Ah! He swiped at me. Bad kitty. There’s no way I’m getting that with that cat on it"

func look_at():
	if game_state.has_item("floppy"):
		return "It's a " + keyword("floppy") + " disk. It holds a whopping 1.44MB of data."
		
	if game_state.get_dialog_state("cat", "complete") == true:
		return "It’s a " + keyword("floppy") + " disk underneath the cat."
	else:
		return "It’s a " + keyword("floppy") + " disk just laying on the floor surrounded by cat hair"

func give(who):
	if who.name == "person":
		game_state.show_dialogue(dialog, "give_floppy")
