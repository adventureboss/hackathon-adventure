extends Node

signal show_dialogue(dialog_file, dialog_entry)
signal items_updated(items)

var _global_items = {}

var _dialog_state: Dictionary = {}
var _items = []

func _init():
	var badge = load("res://Scripts/items/badge.gd").new()
	badge.display_name = "Badge"
	_global_items["badge"] = badge
	
	var pamphlet = load("res://Scripts/items/pamphlets.gd").new()
	pamphlet.display_name = "Pamphlet"
	_global_items["pamphlet"] = pamphlet
	
	var drink_vouchers = load("res://Scripts/items/drink_vouchers.gd").new()
	drink_vouchers.display_name = "Drink vouchers"
	_global_items["drink_vouchers"] = drink_vouchers
	
	var ash_badge = load("res://Scripts/items/ash_badge.gd").new()
	ash_badge.display_name = "Ash Badge"
	_global_items["ash_badge"] = ash_badge
	
	var lens = load("res://Scripts/items/lens.gd").new()
	lens.display_name = "Lens"
	_global_items["lens"] = lens
	
	# set player default state
	set_dialog_state("player", "caffeinated", 0)
	set_dialog_state("player", "east_clear", 0)
	set_dialog_state("player", "west_clear", 0)
	set_dialog_state("player", "items", 0)

func _get_item(item_or_name):
	if typeof(item_or_name) == TYPE_STRING:
		var item = _global_items[item_or_name]
		assert(item != null, "Unknown item used")
		return item
	return item_or_name


func add_item(item):
	self._items.append(_get_item(item))
	emit_signal("items_updated", _items)

func has_item(item):
	return self._items.has(_get_item(item))

func remove_item(item):
	var i = _items.find(_get_item(item))
	_items.remove(i)
	emit_signal("items_updated", _items)
	
func set_dialog_state(actor: String, variable: String, value):
	if not self._dialog_state.has(actor):
		self._dialog_state[actor] = {}
		
	self._dialog_state[actor][variable] = value


func get_dialog_state(actor: String, variable, default = null):
	if not self._dialog_state.has(actor):
		self._dialog_state[actor] = {}
	
	return self._dialog_state[actor].get(variable, default)

	
func handle_quest_turnin(item_value):
	var item_number = get_dialog_state("eventc", "items")
	var result = item_number + item_value
	return result

func show_dialogue(dialogue: Resource, entry: String):
	emit_signal("show_dialogue", dialogue, entry)
