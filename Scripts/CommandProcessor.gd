extends Node

const Actor = preload("res://Scripts/actor.gd")
const help = preload("res://Dialogs/help.tres")

onready var game_state: GameState = get_node("/root/GameState")

func _extract_actors(input: Array, count: int, items: Array = []):
	var search = ""
	for i in input.size():
		var word = input[i]
		if search != "":
			search += "_"
		search += word

		var actor = get_actor(search)
		if actor != null and not actor.is_disabled:
			items.append(actor)
			if i + 1 < input.size() and count > 1:
				return _extract_actors(input.slice(i + 1, input.size()), count - 1, items)
			return items
	
	if input.size() > 1:
		return _extract_actors(input.slice(1, input.size()), count, items)
	
	return items

func _slice(search_words: PoolStringArray, start, end):
	return PoolStringArray(Array(search_words).slice(start, end))

func look_at_room():
	return game_state.current_room.look()

func initialize (starting_room) -> String:
	return change_room(starting_room)


func change_room (new_room) -> String:
	# current_room = new_room
	game_state.current_room = new_room
	return look_at_room()

func update_exit (direction):
	print(game_state.current_room.get_room_name())
	if game_state.current_room.get_room_name() == "East Checkpoint":
		if game_state.get_dialog_state("player", "east_clear"):
			game_state.current_room.exits[direction].exit_is_locked = false
	elif direction == "west" && game_state.current_room.get_room_name() == "West Checkpoint":
		if game_state.get_dialog_state("player", "west_clear"):
			game_state.current_room.exits[direction].exit_is_locked = false


func process_command(input: String):
	var words = input.to_lower().split(" ", false)
	var first_word = words[0]
	var second_word = ""
	
	if words.size() > 1:
		second_word = words[1]
	
	match first_word:
		"talk":
			return talkTo(_slice(words, 2, words.size()))
		"give":
			return give(_slice(words, 1, words.size()))
		"use":
			return use(_slice(words, 1, words.size()))
		"walk":
			return walk(second_word)
		"pick":
			return pickUp(_slice(words, 2, words.size()))
		"look":
			return lookAt(_slice(words, 2, words.size()))
		"help":
			return help()
		_:
			return "Unrecognized command - Please try again."

func get_actor(item: String) -> Actor:
	var actors = []
	
	actors.append(game_state.get_self())
	
	for child in game_state.current_room.get_children():
		if "display_name" in child: # poor's man way to check if its an Actor
			actors.append(child)
				
	for inventory_item in game_state.get_items():
		actors.append(inventory_item)
	
	for actor in actors:
		if actor.name.to_lower() == item:
			return actor

	return null

func help():
	game_state.show_dialogue(help, "help")
	return "You get HELP"

func talkTo (search_words: PoolStringArray) -> String:
	if search_words.size() == 0:
		return "TALK TO who?"
	
	var actors = _extract_actors(search_words, 1)
	
	if actors.size() > 0:
		var response = actors[0].talk_to()
		if response != null:
			return response
	else:
		return "%s is unable to speak at this time." % search_words.join(' ')
	return "You TALK TO %s" % search_words.join(' ')


func give (search_words: PoolStringArray) -> String:
	if search_words.size() == 0:
		return "GIVE what?"
		
	var actors = _extract_actors(search_words, 2)
	
	if actors.size() == 0:
		return "That's not possible"
		
	
	if actors.size() < 2:
		return "GIVE %s <to> <something>" % actors[0].display_name
		
	if game_state.has_item(actors[0]) == false:
		return "I don't have %s" % actors[0].display_name

	return PoolStringArray([ "You GIVE %s to %s" % [actors[0].display_name, actors[1].display_name], actors[1].give(actors[0]) ]).join("\n")

func use (search_words: PoolStringArray) -> String:
	if search_words.size() == 0:
		return "USE <something> or USE <something> on/with >something else>"
		
	var actors = _extract_actors(search_words, 2)
	
	if actors.size() == 0:
		return "I can't use that"
	
	if actors.size() == 1:
		return PoolStringArray([ "You USE %s " % actors[0].display_name, actors[0].use(game_state._self) ]).join("\n")
	
	return PoolStringArray([ "You USE %s with %s" % [actors[0].display_name, actors[1].display_name], actors[0].use(actors[1]) ]).join("\n")

func walk (second_word: String) -> String:
	if second_word == "":
		return "WALK where?"

	if game_state.current_room.exits.keys().has(second_word):
		update_exit(second_word)
		var exit = game_state.current_room.exits[second_word]

		if exit.is_other_room_locked(game_state.current_room):
			return "That exit is currently blocked, you'll need the right badge to get through"
		var change_response = change_room(exit.get_other_room(game_state.current_room))
		return PoolStringArray([ "You WALK %s." % second_word, change_response ]).join("\n")
	else:
		return "This room has no exit in that direction!"


func pickUp (search_words: PoolStringArray) -> String:
	if search_words.size() == 0:
		return "PICK UP what?"
	
	var actors = _extract_actors(search_words, 1)
	
	if actors.size() == 1:
		return PoolStringArray([ "You PICK UP %s" % actors[0].display_name, actors[0].pick_up() ]).join("\n")
	else:
		return "%s can't be picked up" % search_words.join(' ')


func lookAt (search_words: PoolStringArray) -> String:
	if search_words.size() == 0:
		return "LOOK AT what?"
	
	if search_words.size() > 0 and search_words[0] == "room":
		return look_at_room()
	
	var actors = _extract_actors(search_words, 1)
	if actors.size() > 0:
		return PoolStringArray([ "You LOOK AT %s" % actors[0].display_name, actors[0].look_at() ]).join("\n")
	else:
		return "%s can't be looked at, it is unseeable" % search_words.join(' ')
