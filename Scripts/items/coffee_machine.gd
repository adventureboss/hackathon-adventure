extends "res://Scripts/actor.gd"

const dialogue = preload("res://Dialogs/coffee_machine.tres")

func _init():
	game_state.set_dialog_state("coffee_machine", "broken", false)

func look_at():
	if game_state.get_dialog_state("coffee_machine", "broken") == true:
		return "It used to be a fancy coffee machine. I like to think I’ve enhanced it"

	return "It’s a fancy coffee machine. It says, “uses the strongest beans known to man.” Looks like it makes tea too!"

func pick_up():
	game_state.set_dialog_state("coffee_machine", "broken", true)
	return "“You’re coming with me, fancy coffee machine!” You attempt to pick it up and drop it with a loud crash. Beans spill out all over the floor. “Whoops”"

func talk_to():
	game_state.show_dialogue(dialogue, "main")

func use(with):
	return talk_to()

