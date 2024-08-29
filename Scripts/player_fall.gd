extends PlayerState

@export var idle_state : PlayerState
@export var move_state : PlayerState
#@export var climb_state : PlayerState

func process_physics(delta: float) -> PlayerState:
	parent.velocity.y = min(parent.velocity.y + gravity * delta, parent.MAX_FALL_SPEED)
	
	var direction = 0
	if Input.is_action_pressed("left"):
		direction = -1
	if Input.is_action_pressed("right"):
		direction = 1
	parent.update_facing_direction(direction)
	parent.velocity.x = direction * move_speed
	parent.move_and_slide()
	
	if parent.is_on_floor():
		AudioManager.play_landing_sound()
		if direction != 0:
			return move_state
		return idle_state
	
	return null
