extends KinematicBody2D

export var move_speed := 4

func _ready():
	pass


func _process(delta):
	var move_vec := Vector2.ZERO
	
	if Input.is_action_pressed("move_down"):
		move_vec += Vector2.DOWN
	if Input.is_action_pressed("move_up"):
		move_vec += Vector2.UP
	if Input.is_action_pressed("move_left"):
		move_vec += Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		move_vec += Vector2.RIGHT
	
	move_and_slide(move_vec * move_speed * Constants.TILE_WIDTH)
	
	rotation = Vector2.UP.angle_to(get_global_mouse_position() - global_position)
