extends "res://Scripts/actor.gd"

const robot_vendor_dialogue = preload("res://Dialogs/robot_vendor.tres")

func talk_to():
	if game_state.get_dialog_state("robot", "finished") == true:
		return "Yeah, I think he’s fried. Better leave him alone"
	else:
		return game_state.show_dialogue(robot_vendor_dialogue, "main")
		return ""


func look_at():
	return "It's a " + keyword("robot") + "! I love robots!"

