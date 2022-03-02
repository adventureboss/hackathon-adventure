extends "res://Scripts/actor.gd"

const associate_dialogue = preload("res://Dialogs/associate.tres")

func talk_to():
	game_state.show_dialogue(associate_dialogue, "main")
	return null
