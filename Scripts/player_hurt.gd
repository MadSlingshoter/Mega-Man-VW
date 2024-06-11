extends PlayerState

@export var idle_state : PlayerState
@export var move_state : PlayerState
@export var fall_state : PlayerState
#@export var climb_state : PlayerState

@onready var hurt_timer = $HurtTimer

func _ready():
	can_change_to_hurt = false

func enter() -> void:
	super()
	parent.velocity.y = 0
	hurt_timer.start()

func process_physics(delta: float) -> PlayerState:
	parent.velocity.y = min(parent.velocity.y + gravity * delta, parent.MAX_FALL_SPEED)
	if !hurt_timer.is_stopped():
		if parent.animations.flip_h == false:
			parent.velocity.x = -move_speed
		else:
			parent.velocity.x = move_speed
	else:
		if not parent.is_on_floor():
			return fall_state
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			return move_state
		return idle_state
	
	parent.move_and_slide()
	
	return null
