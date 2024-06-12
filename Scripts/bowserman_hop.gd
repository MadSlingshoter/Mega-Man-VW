extends State

@export var breath_fire_state: State
@export var jump_state: State
@export var hop_state: State

const HOP_FORCE: float = -100.0
var has_hopped: bool = false
var random_float: float

@onready var pre_jump_timer = $PreJumpTimer

func enter() -> void:
	super()
	parent.face_player()
	has_hopped = false
	pre_jump_timer.start()

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta * 0.5
		if not has_hopped:
			has_hopped = true
	elif has_hopped:
		random_float = randf()
		if random_float < parent.jump_transition_chance:
			return jump_state
		return breath_fire_state
	parent.move_and_slide()
	return null


func _on_pre_jump_timer_timeout():
	parent.velocity.y = HOP_FORCE
	parent.jump_transition_chance += 0.4
