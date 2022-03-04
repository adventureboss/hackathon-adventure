extends "res://Scripts/actor.gd"

func look_at():
	return "It's a " + keyword("water fountain") + " with " + keyword("cups") + " next to it. There’s little cucumbers floating in it. At least I think those are cucumbers. Yikes! One winked at me"

func pick_up():
	return "Nah, I’ll just spill it everywhere"

func use(with):
	if with.name == "self":
		return "Ahhh delicious dihydrogen-monoxide. You know, even a spoonful can kill. I hope no one saw me put my mouth on that."
		
	if with.name == "cup":
		return with.use(self)
