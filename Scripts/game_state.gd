extends Node

signal show_dialogue(dialog_file, dialog_entry)
signal items_updated(items)

var _global_items = {}

var _dialog_state: Dictionary = {}
var _items = []
var _self
var current_room

func _init():
	_self = _add_global_item("res://Scripts/npc/self.gd", "self", "Self")
	_add_global_item("res://Scripts/items/badge.gd", "badge", "Badge")
	_add_global_item("res://Scripts/items/pamphlets.gd", "pamphlet", "Pamphlet")
	_add_global_item("res://Scripts/items/drink_vouchers.gd", "drink_vouchers", "Drink vouchers")
	_add_global_item("res://Scripts/items/ash_badge.gd", "ash_badge", "Ash badge")
	_add_global_item("res://Scripts/items/lens.gd", "lens", "Lens")
	_add_global_item("res://Scripts/items/cup.gd", "cup", "Cup")
	_add_global_item("res://Scripts/items/water_cup.gd", "water_cup", "Water cup")
	_add_global_item("res://Scripts/items/coffee_cup.gd", "coffee_cup", "Coffee cup")
	_add_global_item("res://Scripts/items/beans_cup.gd", "beans_cup", "Beans cup")
	_add_global_item("res://Scripts/items/chips.gd", "chips", "Chips")
	_add_global_item("res://Scripts/items/password.gd", "password", "Password")
	
	
	# set player default state
	set_dialog_state("player", "caffeinated", 0)
	set_dialog_state("player", "east_clear", 0)
	set_dialog_state("player", "west_clear", 0)
	set_dialog_state("player", "items", 0)
	
	# npc default states when necessary
	set_dialog_state("nerds", "present", true)

func _add_global_item(resource, name, display_name):
	assert(_global_items.has(name) == false, "global items already contains this item")
	var item = load(resource).new()
	item.display_name = display_name
	item.name = name
	_global_items[name] = item
	return item

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
	
func get_self():
	return _self

func remove_item(item):
	var i = _items.find(_get_item(item))
	_items.remove(i)
	emit_signal("items_updated", _items)
	
func get_items():
	return _items
	
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
