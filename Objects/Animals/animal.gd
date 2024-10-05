extends Area2D

var is_being_carried: bool
var mouse_offset

func _ready():
	pass
	
func _process(delta: float) -> void:
	if is_being_carried:
		global_position = get_viewport().get_mouse_position() - mouse_offset


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('click'):
			#print('clicked!')
			is_being_carried = true
			mouse_offset = get_viewport().get_mouse_position() - global_position
		if Input.is_action_just_released("click"):
			#print('unclicked!')	
			is_being_carried = false
