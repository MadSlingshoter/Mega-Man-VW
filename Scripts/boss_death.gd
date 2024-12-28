extends State
## State for when a boss is defeated

## Timer for the duration of the death effects
@onready var death_timer = $DeathTimer
## Source for the energy balls emitted on death
@onready var death_source = preload("res://Characters/Death/death_ball_source.tscn")

## When entering the state, start the death effects and pause the game.
func enter() -> void:
	super()
	parent.process_mode = Node.PROCESS_MODE_ALWAYS
	death_timer.start()
	animations.hide()
	var d = death_source.instantiate()
	parent.add_child(d)
	d.global_position = parent.global_position
	AudioManager.play_death_sound()
	Global.clear_screen()
	get_tree().paused = true

## Callback for when the death timer runs out. Returns to stage select.
func _on_death_timer_timeout():
	get_tree().paused = false
	Global.goto_scene(Global.Level.STAGE_SELECT)
	# should go to animation of Mega Man absorbing boss's power and then teleporting out
