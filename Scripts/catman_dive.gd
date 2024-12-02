extends State

@export var wait_state: State

var dive_angle : Vector2

func enter():
	super()
	parent.slash_animations.show()
	parent.slash_animations.play("dive")
	parent.dive_box.set_deferred("disabled", false)
	# set angle
	dive_angle = Vector2(Global.player.global_position.x - parent.global_position.x, Global.player.global_position.y - parent.global_position.y).normalized()
	dive_angle.y = clamp(dive_angle.y, 0.2, 1)
	dive_angle.normalized()
	AudioManager.play_slash_sound()

func exit():
	super()
	parent.slash_animations.stop()
	parent.slash_animations.hide()
	parent.dive_box.set_deferred("disabled", true)

func process_physics(delta: float) -> State:
	parent.velocity = dive_angle * move_speed
	if parent.is_on_floor():
		return wait_state
	parent.move_and_slide()
	return null
