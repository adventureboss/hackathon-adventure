extends Node


func _ready() -> void:
	$Entrance.connect_exit("north", $Lobby)
	$EastEntrance.connect_exit("west", $Lobby)
	$EastEntrance.connect_exit("south", $SessionRoom)
	$EastEntrance.connect_exit("north", $VendorHall)
	$WestEntrance.connet_exit("east", $Ballroom)
