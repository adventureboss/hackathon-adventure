extends VBoxContainer

onready var game_state = get_node("/root/GameState")

func _ready():
	$Response.connect("meta_clicked", self, "handle")

func set_text(input: String, response: String):
	$InputHistory.text = " > " + input
	$Response.bbcode_text = response

func handle(keyword):
	game_state.emit_signal("keyword_clicked", keyword)
