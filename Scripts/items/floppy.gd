extends "res://Scripts/actor.gd"

func pick_up():
	if game_state.has_item("floppy"):
		return "I already have the floppy."
	
	if game_state.get_dialog_state("cat", "complete") == 1:
		game_state.add_item("floppy")
		return "Got it! It says, “Presentation files. Definitely don’t lose or let a cat sit on it. Should be fine"
	
	if game_state.get_dialog_state("cat", "sleeping") == 1:
		return "I can't pick it up. The cat is above it"
	
	return "Ah! Bad kitty. There’s no way I’m getting that with that cat on it"

func look_at():
	if game_state.has_item("floppy"):
		return "It is a floppy disk"
		
	if game_state.get_dialog_state("cat", "complete") == 0:
		return "t’s a floppy disk underneath the cat."
	else:
		return "It’s a floppy disk just laying on the floor surrounded by cat hair"
