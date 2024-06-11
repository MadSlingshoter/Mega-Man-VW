extends PlayerState

@export var idle_state : PlayerState
@export var move_state : PlayerState
@export var fall_state : PlayerState
#@export var climb_state : PlayerState

@export var jump_speed: float = -285.0

func enter() -> void:
	super()
	parent.velocity.y = jump_speed

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_released("jump"):
		parent.velocity.y = 0   # cannot be in player_fall due to can fall in other states
		return fall_state
	return null

func process_physics(delta: float) -> PlayerState:
	parent.velocity.y = min(parent.velocity.y + gravity * delta, parent.MAX_FALL_SPEED)
	
	if parent.velocity.y > 0:
		return fall_state
	
	var direction = 0
	if Input.is_action_pressed("left"):
		direction = -1
	if Input.is_action_pressed("right"):
		direction = 1
	parent.update_facing_direction(direction)
	parent.velocity.x = direction * move_speed
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if direction != 0:
			return move_state
		return idle_state
	
	return null
