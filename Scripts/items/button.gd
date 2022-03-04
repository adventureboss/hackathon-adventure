extends "res://Scripts/actor.gd"

func look_at():
	return "It's a small hole with a reset " + keyword("button") + ".  If only I could push it"

func use(with):
	return with.use(self)

