extends State

@export var move_state : State
@export var jump_state : State
@export var fall_state : State
@export var slide_state : State
#@export var climb_state : State
@export var hurt_state : State
@export var death_state : State

func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		if Input.is_action_pressed("down"):
			return slide_state
		return jump_state
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		return move_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta # need this?
	parent.move_and_slide()
	
	if not parent.is_on_floor():
		return fall_state
	return null
