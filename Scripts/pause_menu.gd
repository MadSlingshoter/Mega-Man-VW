extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _input(event : InputEvent):
	if(event.is_action_pressed("pause") and Global.can_pause):
		if get_tree().paused:
			unpause()
		else:
			pause()

func pause():
	show()
	get_tree().paused = true

func unpause():
	hide()
	get_tree().paused = false

func _on_button_resume_pressed():
	unpause()


func _on_button_stage_select_pressed():
	unpause()
	Global.can_pause = false
	Global.goto_scene(Global.Level.stage_select)
