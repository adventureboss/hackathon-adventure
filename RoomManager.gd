extends Node


func _ready() -> void:
	$TitleScreen.connect_exit("north", $Entrance)
	$Entrance.connect_exit("north", $Lobby)
	$Lobby.connect_exit("east", $EastEntrance)
	$Lobby.connect_exit("west", $WestEntrance)
	$EastEntrance.connect_exit("east", $EastHall, true)
	$EastHall.connect_exit("south", $SessionRoom)
	$EastHall.connect_exit("north", $VendorHall)
	$WestEntrance.connect_exit("west", $Ballroom, true)
	
