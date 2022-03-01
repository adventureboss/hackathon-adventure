extends Node

signal show_dialogue(dialogue)

var talk_to_dictionary = {
	"associate": {
		"resource": preload("res://Dialogs/associate.tres"),
		"main": "associate_main"
	}
}

func process_command(input: String):
	var words = input.split(" ", false)
	var first_word = words[0].to_lower()
	var second_word = ""
	var third_word = ""

	if words.size() > 1:
		second_word = words[1].to_lower()
	if words.size() > 2:
		third_word = words[2].to_lower()

	match first_word:
		"talk":
			return talkTo(third_word)
		"give":
			return give(second_word)
		"use":
			return use(second_word)
		"walk":
			return walk(second_word)
		"pick":
			return pickUp(third_word)
		"look":
			return lookAt(third_word)
		_:
			return "Unrecognized command - Please try again."


func talkTo (third_word: String) -> String:
	if third_word == "":
		return "TALK TO who?"
	
	if talk_to_dictionary.has(third_word):
		emit_signal("show_dialogue", talk_to_dictionary[third_word].get("resource"), talk_to_dictionary[third_word].get("main"))

	return "You TALK TO %s" % third_word


func give (second_word: String) -> String:
	if second_word == "":
		return "GIVE what?"

	return "You GIVE %s" % second_word


func use (second_word: String) -> String:
	if second_word == "":
		return "USE what?"

	return "You USE %s" % second_word


func walk (second_word: String) -> String:
	if second_word == "":
		return "WALK where?"

	return "You WALK %s" % second_word


func pickUp (third_word: String) -> String:
	if third_word == "":
		return "PICK UP what?"

	return "You PICK UP %s" % third_word


func lookAt (third_word: String) -> String:
	if third_word == "":
		return "LOOK AT what?"

	return "You LOOK AT %s" % third_word
