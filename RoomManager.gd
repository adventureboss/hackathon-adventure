extends Node


func _ready() -> void:
	$Entrance.connect_exit("north", $Lobby)
	$Lobby.connect_exit("east", $EastEntrance, true)
	$Lobby.connect_exit("west", $WestEntrance, true)
	$EastEntrance.connect_exit("east", $EastHall)
	# $EastHall.connect_exit_unlocked("south", $SessionRoom)
	$EastHall.connect_exit("north", $VendorHall)
	$WestEntrance.connect_exit("west", $Ballroom)
	
