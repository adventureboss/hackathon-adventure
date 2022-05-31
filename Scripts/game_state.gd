extends Node

signal show_dialogue(dialog_file, dialog_entry)
signal items_updated(items)
signal keyword_clicked(keyword)
signal room_changed_programatically(room, command)

var _global_items = {}

var _dialog_state: Dictionary = {}
var _items = []
var _self
var rooms
var current_room setget set_current_room
var _previous_room

func _init():
	_self = _add_global_item("res://Scripts/npc/self.gd", "self", "Self")
	_add_global_item("res://Scripts/items/badge.gd", "badge", "Badge")
	_add_global_item("res://Scripts/items/pamphlets.gd", "pamphlet", "Pamphlet")
	_add_global_item("res://Scripts/items/drink_vouchers.gd", "drink_vouchers", "Drink vouchers")
	_add_global_item("res://Scripts/items/ash_badge.gd", "ash_badge", "Ash badge")
	_add_global_item("res://Scripts/laser_pointer.gd", "laser_pointer", "Laser pointer")
	_add_global_item("res://Scripts/items/cup.gd", "cup", "Cup")
	_add_global_item("res://Scripts/items/water_cup.gd", "water_cup", "Water cup")
	_add_global_item("res://Scripts/items/coffee_cup.gd", "coffee_cup", "Coffee cup")
	_add_global_item("res://Scripts/items/beans_cup.gd", "beans_cup", "Beans cup")
	_add_global_item("res://Scripts/items/chips.gd", "chips", "Chips")
	_add_global_item("res://Scripts/items/password.gd", "password", "Password")
	_add_global_item("res://Scripts/items/tea_cup.gd", "tea_cup", "Tea cup")
	_add_global_item("res://Scripts/items/quest_items.gd", "quest_items", "Quest Items")
	_add_global_item("res://Scripts/items/floppy.gd", "floppy", "Floppy")


	# set player default state
	set_dialog_state("player", "caffeinated", 0)
	set_dialog_state("player", "east_clear", 0)
	set_dialog_state("player", "west_clear", 0)
	set_dialog_state("player", "items", 0)

	# npc default states when necessary
	set_dialog_state("nerds", "present", true)
	set_dialog_state("cat", "complete", false)
	set_dialog_state("cat", "sleeping", 0)
	set_dialog_state("cat", "feral", 0)
	set_dialog_state("robot", "finished", false)

func _add_global_item(resource, name, display_name, add_to_inventory = false):
	assert(_global_items.has(name) == false, "global items already contains this item")
	var item = load(resource).new()
	item.display_name = display_name
	item.name = name
	item.game_state = self
	_global_items[name] = item
	if add_to_inventory:
		add_item(item)
	return item


func keyword_link(keyword: String):
	return "[url=%s][color=#cb1eca]%s[/color][/url]" % [keyword, keyword]


func enable_room_item(name: String):
	for element in current_room.get_children():
		if 'display_name' in element and element.name == name:
			element.is_disabled = false
			break


func _get_item(item_or_name):
	if typeof(item_or_name) == TYPE_STRING:
		var item
		if _global_items.has(item_or_name):
			item = _global_items[item_or_name]
		else:
			for element in current_room.get_children():
				if 'display_name' in element and element.name == item_or_name:
					item = element
					break
		assert(item != null, "Unknown item used")
		return item
	return item_or_name

func _load_get_item(item_name):
	var item
	if _global_items.has(item_name):
		item = _global_items[item_name]
	else:
		for room in rooms:
			for element in room.get_children():
				if 'display_name' in element and element.name == item_name:
					item = element
					break
	assert(item != null, "Unknown item loaded")
	return item

func add_item(item):
	self._items.append(_get_item(item))
	emit_signal("items_updated", _items)
	self._update_room()

func has_item(item):
	return self._items.has(_get_item(item))

func get_self():
	return _self

func remove_item(item):
	var i = _items.find(_get_item(item))
	_items.remove(i)
	emit_signal("items_updated", _items)
	self._update_room()

func get_items():
	return _items

func set_dialog_state(actor: String, variable: String, value):
	if not self._dialog_state.has(actor):
		self._dialog_state[actor] = {}

	self._dialog_state[actor][variable] = value
	self._update_room()


func get_dialog_state(actor: String, variable, default = null):
	if not self._dialog_state.has(actor):
		self._dialog_state[actor] = {}

	return self._dialog_state[actor].get(variable, default)


func handle_turnin(item_value):
	var item_number = get_dialog_state("eventc", "items")
	var result = item_number + item_value
	return result

func show_dialogue(dialogue: Resource, entry: String):
	emit_signal("show_dialogue", dialogue, entry)

func _update_room():
	if current_room != null:
		current_room.update()

func set_current_room(new_room):
	if current_room != null:
		_previous_room = current_room
	else:
		_previous_room = new_room
	current_room = new_room

func back_to_previous_room(why = ""):
	var room = _previous_room
	set_current_room(room)
	emit_signal("room_changed_programatically", room, why)

func _room_by_name(name):
	for room in rooms:
		if room.name == name:
			return room
	return null

func load_game(filename: String):
	var file = File.new()
	if file.file_exists(filename):
		file.open(filename, File.READ)
		var game_data = file.get_var()
		file.close()

		for room in rooms:
			if room.name == game_data["current_room"]:
				current_room = room
			if room.name == game_data["previous_room"]:
				_previous_room = room

			if game_data["rooms"].has(room.name):
				for direction in room.exits:
					var exit = room.exits[direction]
					var saved_exit = game_data["rooms"][room.name]["exits"][direction]
					exit.room_1 = _room_by_name(saved_exit.room_1)
					exit.room_2 = _room_by_name(saved_exit.room_2)
					exit.exit_is_locked = saved_exit.exit_is_locked

				var saved_room_items = game_data["rooms"][room.name]["items"]
				for item in room.get_children():
					if "display_name" in item and saved_room_items.has(item.name):
						item.is_disabled = saved_room_items[item.name]["is_disabled"]

		_dialog_state = game_data["dialog_state"]

		_items = []
		for item in game_data["items"]:
			_items.append(_load_get_item(item))

		return true
	else:
		return false


func save_game(filename: String):
	var save_data: Dictionary = {}
	save_data["rooms"] = {}
	for room in rooms:
		save_data["rooms"][room.name] = {
			"items": {},
			"exits": {}
		}

		for direction in room.exits:
			var exit = room.exits[direction]
			save_data["rooms"][room.name]["exits"][direction]   = {
				"exit_is_locked": exit.exit_is_locked,
				"room_1": exit.room_1.name,
				"room_2": exit.room_2.name
			}

		for item in room.get_children():
			if "display_name" in item:
				save_data["rooms"][room.name]["items"][item.name] = {
					"is_disabled": item.is_disabled
				}

	save_data["dialog_state"] = _dialog_state
	save_data["items"] = []
	for item in _items:
		save_data["items"].append(item.name)

	save_data["current_room"] = rooms[rooms.find(current_room)].name
	save_data["previous_room"] = rooms[rooms.find(current_room)].name

	var file = File.new()
	file.open(filename, File.WRITE)
	file.store_var(save_data, true)
	file.close()
