extends PlayerState

@export var idle_state : PlayerState
@export var fall_state : PlayerState

func enter() -> void:
	parent.global_position.x = parent.curr_ladder.global_position.x
	parent.velocity.x = 0
	parent.is_climbing = true

func exit() -> void:
	parent.is_climbing = false
	parent.velocity.y = 0

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed("jump"):
		return fall_state
	return null

func process_physics(delta: float) -> PlayerState:
	var x_direction = 0
	if Input.is_action_pressed("left"):
		x_direction = -1
	if Input.is_action_pressed("right"):
		x_direction = 1
	
	var y_direction = 0
	if parent.shooting_timer.is_stopped():
		if Input.is_action_pressed("up"):
			y_direction = -1
		if Input.is_action_pressed("down"):
			y_direction = 1
	
	parent.update_facing_direction(x_direction)
	parent.velocity.y = y_direction * move_speed
	parent.move_and_slide()
	
	if parent.is_on_floor() or parent.curr_ladder == null:
		return idle_state
	
	return null
