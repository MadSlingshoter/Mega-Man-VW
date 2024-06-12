extends State

@export var hop_state : State

func enter() -> void:
	super()
	parent.face_player()

func process_physics(delta: float) -> State:
	if not animations.is_playing():
		return hop_state
	return null
