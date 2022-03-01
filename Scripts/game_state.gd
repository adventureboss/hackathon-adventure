extends Node

var _dialog_state = {}
var _items = []

func add_item(item):
	self._items.append(item)


func set_dialog_state(actor: String, variable: String, value):
	if not self._dialog_state.has(actor):
		self._dialog_state[actor] = {}
		
	self._dialog_state[actor][variable] = value


func get_dialog_state(actor: String, variable):
	if not self._dialog_state.has(actor):
		self._dialog_state[actor] = {}
	
	return self._dialog_state[actor].get(variable)
