extends Node

const Actor = preload("res://Scripts/actor.gd")

onready var game_state: GameState = get_node("/root/GameState")

var current_room = null


func initialize (starting_room) -> String:
	return change_room(starting_room)


func change_room (new_room) -> String:
	current_room = new_room
	game_state.current_room = new_room
	var exit_string = PoolStringArray(new_room.exits.keys()).join(" ")
	var string = PoolStringArray([
		"You are now in the " + new_room.room_name + ".  \n" + new_room.room_description,
		"Exits: " + exit_string
	]).join("\n")

	return string


func process_command(input: String):
	var words = input.split(" ", false)
	var first_word = words[0].to_lower()
	var second_word = ""
	var third_word = ""
	var fourth_word = ""

	if words.size() > 1:
		second_word = words[1].to_lower()
	if words.size() > 2:
		third_word = words[2].to_lower()
	if words.size() > 3:
		fourth_word = words[3].to_lower()

	match first_word:
		"talk":
			return talkTo(third_word)
		"give":
			return give(second_word, third_word, fourth_word)
		"use":
			return use(second_word, third_word, fourth_word)
		"walk":
			return walk(second_word)
		"pick":
			return pickUp(third_word)
		"look":
			return lookAt(third_word)
		_:
			return "Unrecognized command - Please try again."


func get_actor(item: String) -> Actor:
	var actors = []
	
	actors.append(game_state.get_self())
	
	for child in current_room.get_children():
		if "display_name" in child: # poor's man way to check if its an Actor
			actors.append(child)
				
	for inventory_item in game_state.get_items():
		actors.append(inventory_item)
	
	for actor in actors:
		if actor.name.to_lower() == item:
			return actor
		elif actor.display_name.to_lower() == item:
			return actor

	return null


func talkTo (third_word: String) -> String:
	if third_word == "":
		return "TALK TO who?"
	
	var actor = get_actor(third_word)
	if actor != null:
		var response = actor.talk_to()
		if response != null:
			return response
	else:
		return "%s is unable to speak at this time." % third_word
		
	return "You TALK TO %s" % third_word


func give (second_word: String, third_word: String, fourth_word: String) -> String:
	if second_word == "":
		return "GIVE what?"

	if third_word == "":
		return "GIVE %s <to> <something>" % second_word

	if fourth_word == "":
		return "GIVE %s to what?" % second_word
		
	if game_state.has_item(second_word) == false:
		return "I don't have %s" % second_word

	var actor = get_actor(fourth_word)
	if actor != null:
		return PoolStringArray([ "You GIVE %s to %s" % [second_word, fourth_word], actor.give(second_word) ]).join("\n")
	else:
		return "Can't give an item to %s" % fourth_word


func use (second_word: String, third_word: String, fourth_word: String) -> String:
	if second_word == "":
		return "USE what?"
	
	if third_word != "on":
		return "USE %s || USE %s <on> <something>"

	if fourth_word != "" && game_state.has_item(second_word) == false:
		return "I don't have %s" % second_word

	var actor = get_actor(fourth_word)
	if actor != null:
		if third_word == "" && fourth_word == "":
			return PoolStringArray([ "You USE %s " % second_word, actor.use(second_word) ]).join("\n")
		else:
			return PoolStringArray([ "You USE %s on %s" % [second_word, fourth_word], actor.use(second_word) ]).join("\n")
	else:
		return "%s can't be picked up" % second_word


func walk (second_word: String) -> String:
	if second_word == "":
		return "WALK where?"

	if current_room.exits.keys().has(second_word):
		var exit = current_room.exits[second_word]
		if exit.is_other_room_locked(current_room):
			return "That exit is currently blocked, you'll need the right badge to get through"
		var change_response = change_room(exit.get_other_room(current_room))
		return PoolStringArray([ "You WALK %s." % second_word, change_response ]).join("\n")
	else:
		return "This room has no exit in that direction!"


func pickUp (third_word: String) -> String:
	if third_word == "":
		return "PICK UP what?"

	var actor = get_actor(third_word)
	if actor != null:
		return PoolStringArray([ "You PICK UP %s" % third_word, actor.pick_up() ]).join("\n")
	else:
		return "%s can't be picked up" % third_word


func lookAt (third_word: String) -> String:
	if third_word == "":
		return "LOOK AT what?"
	
	var actor = get_actor(third_word)
	if actor != null:
		return PoolStringArray([ "You LOOK AT %s" % third_word, actor.look_at() ]).join("\n")
	else:
		return "%s can't be looked at, it is unseeable" % third_word
