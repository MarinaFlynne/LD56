extends TextureButton

var is_being_carried: bool
var mouse_offset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_being_carried:
		global_position = get_viewport().get_mouse_position() - mouse_offset





func _on_button_down() -> void:
	is_being_carried = true
	mouse_offset = get_viewport().get_mouse_position() - global_position


func _on_button_up() -> void:
	is_being_carried = false
