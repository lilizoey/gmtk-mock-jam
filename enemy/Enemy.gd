extends KinematicBody2D

onready var vision_area := $VisionArea
onready var sprite := $Sprite

func _ready():
	vision_area.connect("player_spotted", self, "_on_player_spotted")
	vision_area.connect("lost_player", self, "_on_lost_player")
	start_wander()
	
enum states {
	wander,
	chase_prepare,
	chase,
	idle
}

var state: int = states.wander
var current_direction := Vector2.ZERO
var move_speed := 24.0
var timer := 0.0

var can_see_player := false
var player: KinematicBody2D = null

func _process(delta):
	timer -= delta
	
	if abs(current_direction.angle_to(Vector2.DOWN)) < PI/4:
		sprite.frame = 0
	if abs(current_direction.angle_to(Vector2.LEFT)) < PI/4:
		sprite.frame = 1
	if abs(current_direction.angle_to(Vector2.UP)) < PI/4:
		sprite.frame = 2
	if abs(current_direction.angle_to(Vector2.RIGHT)) < PI/4:
		sprite.frame = 3

func _physics_process(delta):
	match state:
		states.wander:
			wander(delta)
		states.chase:
			chase(delta)
		states.idle:
			idle(delta)
		states.chase_prepare:
			chase_prepare(delta)
	
	var angle_diff: float = Vector2.UP.angle_to(current_direction) - $VisionArea.rotation
	if angle_diff > 0.1:
		$VisionArea.rotation += delta * PI  
	elif angle_diff < -0.1:
		$VisionArea.rotation -= delta * PI 
	
	for i in get_slide_count():
		var coll := get_slide_collision(i)
		if coll.collider.is_in_group("Player"):
			coll.collider.die()

func start_wander():
	state = states.wander
	timer = rand_range(1.5, 2.5)
	current_direction = Vector2.UP.rotated(rand_range(0,2 * PI))

func wander(delta):
	if timer <= 0:
		start_idle()
	
	move_and_slide(current_direction.normalized() * move_speed)
	

func start_chase():
	state = states.chase

func chase(delta):
	current_direction = (player.global_position - global_position).normalized()
	move_and_slide(current_direction * move_speed * 4.5)
	
	if not can_see_player:
		start_idle()

func start_idle():
	state = states.idle
	timer = rand_range(0.75, 7.5)

func idle(delta):
	if timer <= 0.0:
		start_wander()

func start_chase_prepare():
	state = states.chase_prepare
	timer = rand_range(1.2, 3.6)

func chase_prepare(delta):
	if timer <= 0.0:
		start_chase()
	
	current_direction = (player.global_position - global_position).normalized()
	
	

func _on_player_spotted(player):
	self.player = player
	start_chase_prepare()
	can_see_player = true

func _on_lost_player():
	start_idle()
	can_see_player = false
