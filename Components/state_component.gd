extends Node

enum STATES {PICKED_UP, IDLE, WALKING, EATING}
var current_state: int = STATES.IDLE


func change_state(new_state: int):
	current_state = new_state
	
