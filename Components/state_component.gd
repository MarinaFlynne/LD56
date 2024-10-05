extends Node

enum STATES {PICKED_UP, IDLE, WALKING, EATING, FALLING}
enum NEEDS {NONE, FOOD, SLEEP}
var current_state: int = STATES.IDLE
var current_need: int = NEEDS.NONE

func change_state(new_state: int):
	current_state = new_state
