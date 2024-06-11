extends MarginContainer

func _ready():
	if Global.num_of_lives < 2:
		Global.num_of_lives = 2
	
	Global.checkpoint_num = 0

func _on_texture_button_pressed():
	Global.goto_scene(Global.Level.bowser_man)
	

func _on_texture_button_2_pressed():
	Global.goto_scene(Global.Level.test2)


func _on_texture_button_3_pressed():
	Global.goto_scene(Global.Level.test_boss)
