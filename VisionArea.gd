extends Area2D

signal player_spotted(player)
signal lost_player

var can_see_player := true

onready var ray_cast := $RayCast2D

func _ready():
	pass


func _physics_process(delta):
	var can_still_see_player := false
	for body in get_overlapping_bodies():
		if body.is_in_group("Player"):
			var player_pos: Vector2 = body.global_position
			ray_cast.cast_to = to_local(player_pos)
			ray_cast.enabled = true
			ray_cast.force_raycast_update()
			
			if ray_cast.is_colliding() and ray_cast.get_collider() == body:
				if not can_see_player:
					emit_signal("player_spotted", body)
				can_still_see_player = true
	
	if can_see_player and not can_still_see_player:
		emit_signal("lost_player")
	
	can_see_player = can_still_see_player
