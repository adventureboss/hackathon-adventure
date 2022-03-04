extends "res://Scripts/actor.gd"

const dialog =  preload("res://Dialogs/coffee_machine.tres")

func use(with):
	if game_state.has_item("drink_vouchers"):
		if with.name == "coffee_machine":
			game_state.show_dialogue(dialog, "main")
	
func give(what):
	return use(what)

func look_at():
	return "I have a lot of vouchers!"
