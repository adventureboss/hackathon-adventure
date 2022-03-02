extends Node

var _dialog_state: Dictionary = {}
var _items = []

func add_item(item):
	self._items.append(item)

func has_item(item):
	return self._items.has(item)

func remove_item(item):
	var i = _items.find(item)
	_items.remove(i)
	
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

