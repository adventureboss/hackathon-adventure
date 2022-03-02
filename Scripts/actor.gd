extends Node

onready var game_state: GameState = get_node("/root/GameState")

func talk_to() -> String:
	return "generic talk to response"

func look_at() -> String:
	return "generic look at response"

func pick_up() -> String:
	return "generic pick up message"

func give(who) -> String:
	return "generic give message"
