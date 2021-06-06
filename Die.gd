extends Area2D


func _ready():
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene("res://DeathScreen.tscn")
