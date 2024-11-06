extends MarginContainer

func _ready():
	if Global.num_of_lives < 2:
		Global.num_of_lives = 2
	
	Global.checkpoint_num = 0
	
	$"VBoxContainer/HBoxContainer2/Select2-2/BossFace/StageButton2-2".grab_focus()



func _on_stage_button_11_pressed():
	Global.goto_scene(Global.Level.bowser_man)

func _on_stage_button_12_pressed():
	Global.goto_scene(Global.Level.car_man)

func _on_stage_button_13_pressed():
	Global.goto_scene(Global.Level.test_boss)

func _on_stage_button_22_pressed():
	Global.goto_scene(Global.Level.test2)

func _on_stage_button_32_pressed():
	Global.goto_scene(Global.Level.cat_man)








