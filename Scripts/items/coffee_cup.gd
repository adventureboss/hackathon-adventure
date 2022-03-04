extends "res://Scripts/actor.gd"

const dialogue = preload("res://Dialogs/clowder_cat.tres")

func look_at():
	return "It's a cup full of coffee"

func use(with):
	if with.name == "cat":
		game_state.remove_item("coffee_cup")
		game_state.add_item("cup")
		game_state.show_dialogue(dialogue, "give_coffee")
	if with.name == "self":
		game_state.remove_item("tea_cup")
		game_state.add_item("cup")
		game_state.set_dialog_state("player", "caffeinated", 1)
		return "Mmmm... that was delicious"
