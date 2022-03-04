extends "res://Scripts/actor.gd"

const dialogue = preload("res://Dialogs/clowder_cat.tres")

func look_at():
	return "Aw, it’s cute. It has a little " + keyword("collar") +  " with a " + keyword("nametag") + ". Ah! He’s laying on a " + keyword("floppy") + " disk!"

func talk_to():
	game_state.show_dialogue(dialogue, "main")

func use(with):
	if game_state.get_dialog_state("cat", "sleeping") == 0:
		if with.name == "coffee_cup":
			game_state.remove_item("coffee_cup")
			game_state.show_dialogue(dialogue, "give_coffee")
			return ""
		elif with.name == "tea_cup":
			game_state.remove_item("tea_cup")
			game_state.show_dialogue(dialogue, "give_tea")
			return ""
		elif with.name == "water_cup":
			game_state.remove_item("water_cup")
			game_state.show_dialogue(dialogue, "give_water")
			return ""
	else:
		return "The " + keyword("cat") + " is already sleeping"

func pick_up():
	if game_state.get_dialog_state("cat", "complete") == false:
		return "I already put the " + keyword("cat") + " out of the way"
	
	if game_state.get_dialog_state("cat", "sleeping") == 1:
		game_state.set_dialog_state("cat", "complete", false)
		return "There. I moved him. He looks much more comfortable"
	else:
		return "Ah! He’s a feisty one. I’m never going to be able to move him like this"
