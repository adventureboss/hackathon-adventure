extends "res://Scripts/actor.gd"

const widget_vendor_dialogue = preload("res://Dialogs/vendor.tres")

func talk_to():
	game_state.show_dialogue(widget_vendor_dialogue, "main")
	return null


func look_at():
	return "I don’t know what he’s selling. But he has some mighty fine swag."

