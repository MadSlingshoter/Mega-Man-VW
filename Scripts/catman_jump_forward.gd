extends State

@export var wait_state: State
@export var charge_slash_state: State

var has_jumped: bool = false
var acceleration_y : float

func _ready():
	acceleration_y = gravity * 0.8

func enter():
	super()
	has_jumped = false
	# find distance to player
	# jump that distance, higher jump for longer distance
	var distance_to_player_x = Global.player.global_position.x - parent.global_position.x
	var time_to_player = abs(distance_to_player_x / move_speed)
	parent.velocity.y = -time_to_player * acceleration_y / 2
	parent.face_player()

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.x = move_speed * parent.direction
		parent.velocity.y += acceleration_y * delta
		if not has_jumped:
			has_jumped = true
	elif has_jumped:
		if parent.player_detector.player_in_area:
			return charge_slash_state
		return wait_state
	
	parent.move_and_slide()
	return null
