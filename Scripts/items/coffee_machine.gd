extends "res://Scripts/actor.gd"

const dialogue = preload("res://Dialogs/coffee_machine.tres")

func _ready():
	game_state.set_dialog_state("coffee_machine", "broken", false)

func look_at():
	if game_state.get_dialog_state("coffee_machine", "broken") == true:
		return "It used to be a fancy " + keyword("coffee machine") + ". I like to think I’ve enhanced it"

	return "It’s a fancy " + keyword("coffee machine") + ". It says, “uses the strongest beans known to man.” Looks like it makes tea too! I can even have a " + keyword("stir stick") + "!"

func pick_up():
	if game_state.get_dialog_state("coffee_machine", "broken") == true:
		return "I would, but that's a lot of parts to carry."
	if game_state.get_dialog_state("cat", "complete") == 0:
		return "I'd try, but I could drop it on the " + keyword("cat") + ". He should move first."
	game_state.set_dialog_state("coffee_machine", "broken", true)
	return "“You’re coming with me, fancy " + keyword("coffee machine") + "!” You attempt to pick it up and drop it with a loud crash. " + keyword("Beans") + " spill out all over the floor. “Whoops”"

func talk_to():
	game_state.show_dialogue(dialogue, "main")

func use(with):
	return talk_to()

