extends VBoxContainer


func set_text(input: String, response: String):
	$InputHistory.text = " > " + input
	$Response.bbcode_text = response
