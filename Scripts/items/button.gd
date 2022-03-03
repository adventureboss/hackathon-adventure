extends "res://Scripts/actor.gd"

func look_at():
	return "It's a small hole with a reset button.  If only I could push it"


func use(object):
	# add a way to just use object (singular) not on something
	if object == "button":
		return "My fingers are too big.  I can't just push it"
	elif object == "stir_stick":
		game_state.add_item("password")
		return PoolStringArray([
			"Aha! I pressed it. it must be resetting.  It says the password is 'PowerBacon'.  Now I'm hungry.",
			"<Password added to your inventory>"
		]).join("\n")
	else:
		return "That won't work"
