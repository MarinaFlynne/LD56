extends Node

var is_facing_left: bool

@export var move_speed: int
@export_range(0, 100) var move_chance: int ## Chance to start moving per tick (0-100%)

@export var min_move_ticks: int = 1
@export var max_move_ticks: int = 6

var move_ticks = 0
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_move_state() -> bool:
	var random_check: int = randi_range(0,100)
	if random_check <= move_chance:
		move_ticks = randi_range(min_move_ticks, max_move_ticks)
		direction = Vector2(randf_range(-10, 10), randf_range(-10, 10))
		direction = direction.normalized()
		return true
	else:
		return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
