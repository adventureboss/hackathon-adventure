extends "res://Scripts/actor.gd"

const west_guard_dialogue = preload("res://Dialogs/west_guard.tres")

func talk_to():
	game_state.show_dialogue(west_guard_dialogue, "main")
	return null


func look_at():
	return "It's a skinny security guard standing at the west entrance"


func pick_up():
	return "I could, but I skipped arm day"


func use(item):
	return "No way."


func give(item: String):
	# Add link to dialogue here
	if item == "badge":
		game_state.show_dialogue(west_guard_dialogue, "give_badge")
		return ""
	elif item == "ash_badge":
		game_state.show_dialogue(west_guard_dialogue, "give_ash_badge")
		return ""
	else:
		return "I don't think I can give him that"
