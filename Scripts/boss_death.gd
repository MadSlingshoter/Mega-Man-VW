extends State

@onready var death_timer = $DeathTimer
@onready var death_source = preload("res://Characters/Death/death_ball_source.tscn")
var d

func enter() -> void:
	parent.process_mode = Node.PROCESS_MODE_ALWAYS
	death_timer.start()
	animations.hide()
	d = death_source.instantiate()
	parent.add_child(d)
	d.global_position = parent.global_position
	AudioManager.play_death_sound()
	Global.clear_screen()
	get_tree().paused = true


func process_physics(delta: float) -> State:
	if death_timer.is_stopped():
		get_tree().paused = false
		Global.goto_scene(Global.Level.stage_select)
		# should go to animation of Mega Man absorbing boss's power and then teleporting out
	return null
