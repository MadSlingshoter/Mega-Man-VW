extends State
## State for when the boss spawns into a boss room. 

## Signal for the main boss class that the intro pose animation has been finished.
signal pose_finished()
## Signal for the main boss class that it should add the collision back.
signal add_collision()

## Timer for how long the boss should be without collision at the start.
@onready var collision_timer = $CollisionTimer

## Flag for that the boss is on the floor and doing its intro pose
var _is_posing: bool = false

## When entering the state, pause the game and start the collision timer.
func enter() -> void:
	super()
	Global.can_pause = false
	parent.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	collision_timer.start()

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	if parent.is_on_floor() and not _is_posing:
		animations.play("intro")
		_is_posing = true
		# connect with animation finished
		animations.animation_finished.connect(_on_pose_finished)
	parent.move_and_slide()
	return null

# Callback when the intro pose finishes that sends a signal to the main boss class to fill the 
# healthbar
func _on_pose_finished():
	emit_signal("pose_finished")
	animations.animation_finished.disconnect(_on_pose_finished)

# Callback when the timer timeouts that sends a signal to the main boss class to add the collision
func _on_collision_timer_timeout():
	emit_signal("add_collision")
