extends State

@onready var wait_timer = $WaitTimer

@export var jump_forward_state: State
@export var jump_back_state: State
@export var charge_slash_state: State

@export var randf_from: float
@export var randf_to: float

var switch_state: bool = false

func enter():
	super()
	var wait_time = randf_range(randf_from, randf_to)
	wait_timer.start(wait_time)
	parent.face_player()

func process_physics(delta: float) -> State:
	if wait_timer.is_stopped():
		parent.face_player()
		# slash if player close
		# jump back if not close to wall
		# jump at player
		if parent.player_detector.player_in_area:
			return charge_slash_state
		else:
			if parent.raycast_back.is_colliding():
				return jump_forward_state
			elif parent.raycast_forward.is_colliding():
				return jump_back_state
			else:
				# make something that makes it so higher probability of back jump when further away
				var choose = randi_range(0, 1)
				if choose == 0:
					return jump_forward_state
				else:
					return jump_back_state
	
	return null

