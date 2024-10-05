extends RigidBody2D

@onready var state_comp: Node = $StateComponent
@onready var move_comp: Node = $MoveComponent
@onready var sprite: Sprite2D = $Sprite2D
var is_being_carried: bool
var mouse_offset
@export var fall_position_y = 105

var previous_position_x: float = position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state_comp.current_state != state_comp.STATES.PICKED_UP:
		#position = position.clamp(Vector2(5, 5), Vector2(315, 175))
		pass

	if state_comp.current_state == state_comp.STATES.PICKED_UP:
		global_position = get_viewport().get_mouse_position() - mouse_offset

	elif state_comp.current_state == state_comp.STATES.WALKING:
		previous_position_x = position.x
		position = (position + move_comp.direction / 10).clamp(Vector2(5, fall_position_y - 5), Vector2(315, 175))
		if previous_position_x <= position.x:
			if move_comp.is_facing_left == false:
				move_comp.is_facing_left = true
				sprite.flip_h = false
		else:
			if move_comp.is_facing_left == true:
				move_comp.is_facing_left = false
				sprite.flip_h = true
		pass
		
	if $BottomPoint.global_position.y <= fall_position_y: 
		if state_comp.current_state != state_comp.STATES.PICKED_UP:
			state_comp.current_state = state_comp.STATES.FALLING
		freeze = false
	else:
		if state_comp.current_state == state_comp.STATES.FALLING:
			state_comp.current_state = state_comp.STATES.IDLE
		freeze = true
		linear_velocity = Vector2.ZERO

func walk():
	position = position + move_comp.direction * move_comp.move_speed
	pass

func _on_texture_button_button_down() -> void:
	state_comp.change_state(state_comp.STATES.PICKED_UP)
	mouse_offset = get_viewport().get_mouse_position() - global_position


func _on_texture_button_button_up() -> void:
	linear_velocity = Vector2.ZERO
	position = position.clamp(Vector2(5, 5), Vector2(315, 175))
	state_comp.change_state(state_comp.STATES.IDLE)


func _on_tick_timeout() -> void:
	if state_comp.current_state == state_comp.STATES.IDLE:
		var moving: bool = move_comp.update_move_state()
		if moving:
			state_comp.current_state = state_comp.STATES.WALKING
	elif state_comp.current_state == state_comp.STATES.WALKING:
		move_comp.move_ticks -= 1 # decrease the amount of time left to move
		if move_comp.move_ticks <= 0: #if there are no move ticks left, stop moving
			state_comp.current_state = state_comp.STATES.IDLE
		pass


func _on_hunger_timeout() -> void:
	if state_comp.current_need == state_comp.NEEDS.NONE:
		state_comp.current_need = state_comp.NEEDS.FOOD
		pass
