extends "res://Scripts/actor.gd"

const nerds_dialogue = preload("res://Dialogs/nerds.tres")


func talk_to():
	if game_state.get_dialog_state("nerds", "present"):
		game_state.show_dialogue(nerds_dialogue, "main")
		return null
	else:
		game_state.show_dialogue(nerds_dialogue, "gone")
		return null

func look_at():
	if game_state.get_dialog_state("nerds", "present"):
		return "It's a cluster of " + keyword("nerds") + ". Looks like five of them. They seem to be in a heated debate."
	else:
		return "I can't look at them anymore. They checked in."
	
func pick_up():
	return "I don't think so"
