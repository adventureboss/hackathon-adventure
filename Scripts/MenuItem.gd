extends HBoxContainer

func _ready():
	set_selected(false)

func set_text(value: String):
	$Value.bbcode_text = value

func set_selected(is_selected: bool):
	if is_selected:
		$Selection.bbcode_text = " >"
	else:
		$Selection.bbcode_text = ""
