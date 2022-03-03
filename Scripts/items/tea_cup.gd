extends "res://Scripts/actor.gd"

const dialog = preload("res://Dialogs/clowder_cat.tres")

func look_at():
	return "It's a cup of relaxing sleepytime tea."

func use(with):
	if with.name == "cat":
		game_state.show_dialog(dialog, "give_tea")
	if with.name == "self":
		game_state.remove_item("tea_cup")
		game_state.add_item("cup")
		return "Mmmm... that was delicious"
