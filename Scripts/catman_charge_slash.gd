extends State

@onready var charge_timer = $ChargeTimer

@export var slash_state: State


func enter():
	super()
	charge_timer.start()
	parent.face_player()


func process_physics(delta: float) -> State:
	if charge_timer.is_stopped():
		return slash_state
	return null
