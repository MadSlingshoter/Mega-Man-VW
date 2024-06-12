extends State

@export var butt_stomp_state : State

const JUMP_FORCE: float = -280.0

@onready var pre_jump_timer = $PreJumpTimer

func enter() -> void:
	super()
	parent.face_player()
	parent.jump_transition_chance = -0.6
	parent.hop_count = 0
	pre_jump_timer.start()

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta * 0.5
		parent.velocity.x = move_speed * parent.direction
		if (parent.direction < 0 and parent.global_position.x - Global.player.global_position.x < 3) or (parent.direction > 0 and parent.global_position.x - Global.player.global_position.x > -3) or parent.velocity.y > 0:
			return butt_stomp_state
	parent.move_and_slide()
	return null


func _on_timer_timeout():
	parent.velocity.y = JUMP_FORCE
