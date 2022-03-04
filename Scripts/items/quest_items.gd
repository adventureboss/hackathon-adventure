extends "res://Scripts/actor.gd"

func look_at():
	return PoolStringArray(["It's my list of items. I need", "A lens", "the presentation floppy disk", "and the wifi password"]).join('/n')
