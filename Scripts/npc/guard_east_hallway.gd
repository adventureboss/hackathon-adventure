extends "res://Scripts/actor.gd"

const east_guard_dialogue = preload("res://Dialogs/east_guard.tres")

func talk_to():
	game_state.show_dialogue(east_guard_dialogue, "main")


func give(what):
	match(what.name):
		"badge":
			game_state.show_dialogue(east_guard_dialogue, "badge")
		"ash_badge":
			game_state.show_dialogue(east_guard_dialogue, "badge")
		_:
			return "I don't think they want that"

func pick_up():
	return "He's huge!"
