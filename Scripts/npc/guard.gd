extends "res://Scripts/actor.gd"

const west_guard_dialogue = preload("res://Dialogs/west_guard.tres")

func talk_to():
	game_state.show_dialogue(west_guard_dialogue, "main")
	return null


func look_at():
	return "It's a big security guard standing at the west enterance"


func pick_up():
	return "I could, but I skipped arm day"


func use(item):
	return "NO way!"


func give(item: String):
	# Add link to dialogue here
	if item == "badge":
		game_state.show_dialogue(west_guard_dialogue, "player_badge")
		return ""
	elif item == "ash_badge":
		game_state.show_dialogue(west_guard_dialogue, "nick_badge")
		return ""
	else:
		return "I don't think I can give him that"