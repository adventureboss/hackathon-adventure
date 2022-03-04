extends "res://Scripts/actor.gd"

var look_at_responses = [
	"“12pm - The Marvelous Cloud: Running your apps on someone else’s machine”",
	"“2pm - Python 101: Not your great grandmother’s programming language”",
	"“4pm - Open Hybrid Open Source Open Mouth” Hmm…",
	"“6pm - Why are you still here? It’s beer time.”",
	" I guess that’s the last event"
]

func _ready():
	game_state.set_dialog_state("east_hall_sign", "look_at_index", 0)

func look_at():
	var state = game_state.get_dialog_state("east_hall_sign", "look_at_index")
	var response = look_at_responses[state]
	if state + 1 < look_at_responses.size():
		game_state.set_dialog_state("east_hall_sign", "look_at_index", state + 1)
	
	return response
