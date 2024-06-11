extends MarginContainer

func _ready():
	$VBoxContainer/ButtonStart.grab_focus()

func _on_button_start_pressed():
	Global.goto_scene(Global.Level.stage_select)
	


func _on_button_exit_pressed():
	get_tree().quit()
