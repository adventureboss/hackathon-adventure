extends "res://Scripts/actor.gd"

const dialogue = preload("res://Dialogs/clowder_cat.tres")

func look_at():
	return "Aw, it’s cute. It has a little " + keyword("collar") +  " with a " + keyword("nametag") + ". Ah! He’s laying on a " + keyword("floppy") + " disk!"

func talk_to():
	game_state.show_dialog(dialogue, "main")

func use(with):
	if game_state.get_dialog_state("cat", "sleeping") == 0:
		if with.name == "coffee_cup":
			return with.use(self)
		elif with.name == "sleepytime_tea":
			# Todo: move to sleepytime_tea
			# Todo: Update room description
			return "The " + keyword("cat") + " falls sleep on the floor"
	
	return "The " + keyword("cat") + " is already sleeping"

func pick_up():
	if game_state.get_dialog_state("cat", "complete") == 1:
		return "I already put the " + keyword("cat") + " out of the way"
	
	if game_state.get_dialog_state("cat", "sleeping") == 1:
		game_state.set_dialog_state("cat", "complete", 1)
		return "There. I moved him. He looks much more comfortable"
	else:
		return "Ah! He’s a feisty one. I’m never going to be able to move him like this"
