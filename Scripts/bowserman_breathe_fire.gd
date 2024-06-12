extends State

@export var hop_state : State

const HOP_FORCE: float = -100.0
var has_hopped: bool = false

@onready var pre_jump_timer = $PreJumpTimer
@onready var basic_shot = preload("res://Characters/Bosses/bowserman_fire.tscn")
var b

func enter() -> void:
	super()
	parent.face_player()
	has_hopped = false
	pre_jump_timer.start()
	animations.animation_finished.connect(_on_fire_ready)

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta * 0.5
		if not has_hopped:
			has_hopped = true
	elif has_hopped:
		return hop_state
	parent.move_and_slide()
	return null

func _on_fire_ready():
	b = basic_shot.instantiate()
	b.init(parent.direction)
	get_parent().add_child(b)
	b.global_position = parent.fire_point.global_position
	animations.animation_finished.disconnect(_on_fire_ready)

func _on_pre_jump_timer_timeout():
	parent.velocity.y = HOP_FORCE
