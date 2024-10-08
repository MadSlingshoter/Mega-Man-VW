extends PlayerState

@export var move_state : PlayerState
@export var jump_state : PlayerState
@export var fall_state : PlayerState
@export var slide_state : PlayerState
@export var climb_state : PlayerState

func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_pressed("up") or (Input.is_action_pressed("down") and parent.ladder_down_cast.is_colliding()):
		# Move down to grab ladder below
		if Input.is_action_pressed("down") and parent.ladder_down_cast.is_colliding():
			parent.position.y += 3
			parent.curr_ladder = parent.ladder_down_cast.get_collider()
		if parent.curr_ladder != null:
			return climb_state
	
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		if Input.is_action_pressed("down"):
			return slide_state
		return jump_state
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return move_state
	return null

func process_physics(delta: float) -> PlayerState:
	parent.move_and_slide()
	
	if not parent.is_on_floor():
		return fall_state
	return null
