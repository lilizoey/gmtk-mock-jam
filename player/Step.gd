extends Node2D


export var frequency := 0.5
var timer := 0.0
var playing := false

func _ready():
	pass # Replace with function body.


func _process(delta):
	timer -= delta
	if timer < 0 and playing:
		timer = 0.5
		play()

func play():
	get_child(int(rand_range(0, get_child_count()))).playing = true
