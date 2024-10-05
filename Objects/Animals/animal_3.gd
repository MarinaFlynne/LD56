extends RigidBody2D

@onready var state_comp: Node = $StateComponent
@onready var move_comp: Node = $MoveComponent
var is_being_carried: bool
var mouse_offset
@export var fall_position_y = 140


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state_comp.current_state != state_comp.STATES.PICKED_UP:
		position = position.clamp(Vector2(0, 0), get_viewport().size)
	if state_comp.current_state == state_comp.STATES.PICKED_UP:
		global_position = get_viewport().get_mouse_position() - mouse_offset
	elif state_comp.current_state == state_comp.STATES.WALKING:
		position = position + move_comp.direction / 10
		#walk()
	if $BottomPoint.global_position.y <= fall_position_y: 
		gravity_scale = 0.5
	else:
		gravity_scale = 0
		linear_velocity = Vector2.ZERO

func walk():
	position = position + move_comp.direction * move_comp.move_speed
	pass

func _on_texture_button_button_down() -> void:
	state_comp.change_state(state_comp.STATES.PICKED_UP)
	mouse_offset = get_viewport().get_mouse_position() - global_position


func _on_texture_button_button_up() -> void:
	linear_velocity = Vector2.ZERO
	state_comp.change_state(state_comp.STATES.IDLE)


func _on_tick_timeout() -> void:
	print(state_comp.current_state)
	if state_comp.current_state == state_comp.STATES.IDLE:
		var moving: bool = move_comp.update_move_state()
		if moving:
			state_comp.current_state = state_comp.STATES.WALKING
			print("started walking")
	elif state_comp.current_state == state_comp.STATES.WALKING:
		move_comp.move_ticks -= 1 # decrease the amount of time left to move
		if move_comp.move_ticks <= 0: #if there are no move ticks left, stop moving
			state_comp.current_state = state_comp.STATES.IDLE
		pass
