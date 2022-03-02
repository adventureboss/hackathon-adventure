extends Node


func _ready() -> void:
	$Entrance.connect_exit_unlocked("north", $Lobby)
	$Lobby.connect_exit_locked("east", $EastEntrance)
	$Lobby.connect_exit_locked("west", $WestEntrance)
	$EastEntrance.connect_exit_unlocked("east", $EastHall)
	# $EastHall.connect_exit_unlocked("south", $SessionRoom)
	$EastHall.connect_exit_unlocked("north", $VendorHall)
	$WestEntrance.connect_exit_unlocked("west", $Ballroom)
	
