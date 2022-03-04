extends Node

onready var game_state: GameState = get_node("/root/GameState")
export var display_name: String
export var is_disabled: bool

func talk_to() -> String:
	return "I can't talk with " + self.display_name

func look_at() -> String:
	return "That looks like a regular " + self.display_name

func pick_up() -> String:
	return "I can't pick that up"

func give(who) -> String:
	return "I don't think " + self.display_name + " would like a " + who.display_name

func use(with_what) -> String:
	return "I can't use it with that!"

func keyword(keyword: String):
	return game_state.keyword_link(keyword)
