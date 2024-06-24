extends MarginContainer

func _ready():
	$VBoxContainer/ButtonContinue.grab_focus()
	
	if Global.num_of_lives < 2:
		Global.num_of_lives = 2
	
	Global.checkpoint_num = 0

func _on_button_continue_pressed():
	Global.restart_level()


func _on_button_stage_select_pressed():
	Global.goto_scene(Global.Level.stage_select)

func _on_button_quit_pressed():
	Global.goto_scene(Global.Level.start_menu)
