extends PlayerState

@onready var death_timer = $DeathTimer

func _ready():
	can_change_to_hurt = false

func enter() -> void:
	death_timer.start()
	Global.can_pause = false

func process_physics(delta: float) -> PlayerState:
	if death_timer.is_stopped():
		if Global.num_of_lives == 0:
			Global.goto_scene(Global.Level.continue_menu) # go to continue screen
		else:
			Global.num_of_lives -= 1
			Global.restart_level()
	return null
