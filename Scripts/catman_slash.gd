extends State

@export var wait_state: State


func enter():
	super()
	parent.slash_animations.show()
	parent.slash_animations.play("slash")
	parent.slash_box.set_deferred("disabled", false)
	AudioManager.play_slash_sound()

func exit():
	super()
	if parent.slash_animations.is_playing():
		parent.slash_animations.stop()
	parent.slash_animations.hide()
	parent.slash_box.set_deferred("disabled", true)

func process_physics(delta: float) -> State:
	if not parent.slash_animations.is_playing():
		return wait_state
	return null

