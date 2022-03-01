extends Node


func _ready() -> void:
	$Enterance.connect_exit("north", $Lobby)
