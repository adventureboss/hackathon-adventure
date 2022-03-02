extends "res://Scripts/actor.gd"

const associate_dialogue = preload("res://Dialogs/associate.tres")
const new_associate_dialogue = preload("res://Dialogs/new_associate.tres")

func talk_to():
	if game_state.get_dialog_state("nerds", "checked_in"):
		game_state.show_dialogue(new_associate_dialogue, "main")
		return null
	else:
		game_state.show_dialogue(associate_dialogue, "main")
		return null


func look_at():
	return "It's a person handing out badges"


func pick_up():
	return "I don't think so"
