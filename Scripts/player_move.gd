extends PlayerState

@export var idle_state : PlayerState
@export var jump_state : PlayerState
@export var fall_state : PlayerState
@export var slide_state : PlayerState
@export var climb_state : PlayerState


func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_pressed("up") or (Input.is_action_pressed("down") and parent.ladder_down_cast.is_colliding()):
		# Move down to grab ladder below
		if Input.is_action_pressed("down") and parent.ladder_down_cast.is_colliding():
			parent.position.y += 3
		if parent.curr_ladder != null:
			return climb_state
	
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		if Input.is_action_pressed("down"):
			return slide_state
		return jump_state
	return null

func process_physics(delta: float) -> PlayerState:
	var direction = 0
	if Input.is_action_pressed("left"):
		direction = -1
	if Input.is_action_pressed("right"):
		direction = 1
	
	if direction == 0:
		return idle_state
	
	parent.update_facing_direction(direction)
	parent.velocity.x = direction * move_speed
	parent.move_and_slide()
	
	if not parent.is_on_floor():
		return fall_state
	
	return null
