extends "res://Scripts/actor.gd"

const dialog = preload("res://Dialogs/event_coordinator.tres")

func look_at():
	return "The password is 'PowerBacon'.  Now I'm hungry"

func give(who):
	if who.name == "person":
		game_state.show_dialogue(dialog, "give_password")
