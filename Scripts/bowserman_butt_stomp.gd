extends State

@export var stand_up_state : State

const STOMP_SPEED : float = 250

@onready var delay_timer = $DelayTimer

func enter() -> void:
	super()
	delay_timer.start()
	parent.velocity.x = 0
	parent.velocity.y = 0

func process_physics(delta: float) -> State:
	if parent.is_on_floor():
		return stand_up_state
	if delay_timer.is_stopped():
		parent.velocity.y = STOMP_SPEED
	parent.move_and_slide()
	return null

