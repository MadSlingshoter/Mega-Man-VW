extends State

signal pose_finished()
signal add_collision()

@onready var collision_timer = $CollisionTimer

var is_posing: bool = false

func enter() -> void:
	super()
	Global.can_pause = false
	parent.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	collision_timer.start()

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	if parent.is_on_floor() and not is_posing:
		animations.play("intro")
		is_posing = true
		# connect with animation finished
		animations.animation_finished.connect(_on_pose_finished)
	parent.move_and_slide()
	return null

# signal that sends a signal to the main boss class to fill the healthbar
func _on_pose_finished():
	emit_signal("pose_finished")
	animations.animation_finished.disconnect(_on_pose_finished)


func _on_collision_timer_timeout():
	emit_signal("add_collision")
