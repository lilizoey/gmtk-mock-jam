extends KinematicBody2D

export var move_speed := 4

onready var step := $Step
onready var sprite := $Sprite
onready var light_cone := $LightCone

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
	
	step.playing = move_vec.length() > 0.05
	
	move_and_slide(move_vec.normalized() * move_speed * Constants.TILE_WIDTH)
	
	var facing_direction := get_global_mouse_position() - global_position
	
	light_cone.rotation = Vector2.UP.angle_to(facing_direction)
	
	if abs(Vector2.LEFT.angle_to(facing_direction)) < PI/4:
		sprite.frame = 0
	if abs(Vector2.RIGHT.angle_to(facing_direction)) < PI/4:
		sprite.frame = 1
	if abs(Vector2.UP.angle_to(facing_direction)) < PI/4:
		sprite.frame = 2
	if abs(Vector2.DOWN.angle_to(facing_direction)) < PI/4:
		sprite.frame = 3

func die():
	get_tree().change_scene("res://gui/DeathScreen.tscn")
