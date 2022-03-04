extends "res://Scripts/actor.gd"

func look_at():
	return "It's a small hole with a reset " + keyword("button") + ".  If only I could push it"

func use(with):
	if with.name == "self":
		return "I can't push it. My fingers are too big"
	else:
		return with.use(self)

