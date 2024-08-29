extends PlayerState

@onready var death_timer = $DeathTimer
@onready var death_source = preload("res://Characters/Death/death_ball_source.tscn")
var d

func _ready():
	can_change_to_hurt = false

func enter() -> void:
	death_timer.start()
	AudioManager.play_death_sound()
	parent.animations.hide()
	Global.can_pause = false
	d = death_source.instantiate()
	parent.add_child(d)
	d.global_position = parent.global_position

func process_physics(delta: float) -> PlayerState:
	if death_timer.is_stopped():
		if Global.num_of_lives == 0:
			Global.goto_scene(Global.Level.continue_menu) # go to continue screen
		else:
			Global.num_of_lives -= 1
			Global.restart_level()
	return null
