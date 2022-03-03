extends "res://Scripts/actor.gd"

const dialogue_cat = preload("res://Dialogs/clowder_cat.tres")

func look_at():
	return "It's a cup full of coffee"

func use(with):
	if with.name == "cat":
		return "The cat starts vibrating, it growls with the ferocity of a lion and chases you out of the room! *back to the east hallway"
