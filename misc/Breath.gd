extends AudioStreamPlayer


export var probability := 0.025

func _ready():
	pass # Replace with function body.


func _process(delta):
	if not playing:
		if rand_range(0, 1) < probability * delta:
			playing = true
