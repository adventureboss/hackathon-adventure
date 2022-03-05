extends "res://Scripts/actor.gd"

const dialog = preload("res://Dialogs/event_coordinator.tres")

func give(who):
	if who.name == "person":
		game_state.show_dialogue(dialog, "give_lens")
