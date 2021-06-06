extends Position2D

export var stretch_curve: Curve
export var max_range := 48.0

func _ready():
	pass # Replace with function body.

func _process(delta):
	var parent_pos: Vector2 = get_parent().global_position
	var mouse_pos := get_global_mouse_position()
	
	var relative_mouse_pos := mouse_pos - parent_pos
	relative_mouse_pos.y *= 320/180
	var stretch_to := stretch_curve.interpolate(clamp(relative_mouse_pos.length() / max_range, 0, 1))
	global_position = parent_pos + relative_mouse_pos.normalized() * stretch_to
