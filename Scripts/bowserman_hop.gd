extends State

@export var breath_fire_state : State
@export var jump_state : State
@export var HOP_FORCE: float = -100.0

var is_first_hop: bool = true
var transition_chance: float = -0.3

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta
		# chance to breathe fire
	else:
		parent.face_player()
		if is_first_hop:
			hop()
			is_first_hop = false
		elif randf() < transition_chance:
			return jump_state
		else:
			#transition_chance += 0.3
			hop()
	return null

func hop():
	parent.velocity.y = HOP_FORCE

