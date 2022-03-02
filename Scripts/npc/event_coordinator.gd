extends "res://Scripts/actor.gd"

const event_coordinator_dialogue = preload("res://Dialogs/event_coordinator.tres")

func talk_to():
	game_state.show_dialogue(event_coordinator_dialogue, "main")


func give(what):
	match(what.name):
		"lens":
			game_state.show_dialogue(event_coordinator_dialogue, "lens")
		"floppy":
			game_state.show_dialogue(event_coordinator_dialogue, "floppy")
		"password":
			game_state.show_dialogue(event_coordinator_dialogue, "password")
		_:
			return "I don't think they want that"
