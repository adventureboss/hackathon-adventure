extends VBoxContainer

signal actioned(next_id)

const Line = preload("res://addons/dialogue_manager/dialogue_line.gd")
const MenuItem = preload("res://Scenes/MenuItem.tscn")

onready var actor = $Margin/Body/Actor
onready var content = $Margin/Body/Content
onready var menu = $Margin/Body/Margin/Menu

var dialogue: Line

func _ready():
	self.visible = false
	
	if not dialogue:
		queue_free()
		return
	
	if dialogue.character != "":
		actor.visible = true
		actor.bbcode_text = dialogue.character
	else:
		actor.visible = false
		
	content.dialogue = dialogue
	
	self.visible = true
	
	content.type_out()
	yield(content, "finished")
	
	menu.is_active = false
	
	if dialogue.responses.size() > 0:
		for response in dialogue.responses:
			var item = MenuItem.instance()
			item.set_text(response.prompt)
			menu.add_child(item)
	
	menu.visible = false
	# menu.pointer = $Margin/Body/Margin/Menu/Pointer
	
	var next_id: String = ""
	if dialogue.responses.size() > 0:
		menu.is_active = true
		menu.visible = true
		menu.index = 0
		var response = yield(menu, "actioned")
		next_id = dialogue.responses[response[0]].next_id
	else:
		while true:
			if Input.is_action_just_pressed("ui_accept"):
				next_id = dialogue.next_id
				break
			yield(get_tree(), "idle_frame")
	
	# Send back input
	emit_signal("actioned", next_id)
	queue_free()

