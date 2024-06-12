extends State

@export var face_player_state : State

func process_physics(delta: float) -> State:
	if not animations.is_playing():
		return face_player_state
	return null
