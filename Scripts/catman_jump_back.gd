extends State

@export var wait_state: State
@export var dive_state: State
@export var JUMP_FORCE: float

var has_jumped: bool

func enter():
	super()
	parent.face_player()
	parent.velocity.y = JUMP_FORCE
	has_jumped = false

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta * 0.5
		parent.velocity.x = move_speed * parent.direction * -1
		if not has_jumped:
			has_jumped = true
	elif has_jumped:
		return wait_state
	if parent.is_on_wall():
		return dive_state
	parent.move_and_slide()
	return null
