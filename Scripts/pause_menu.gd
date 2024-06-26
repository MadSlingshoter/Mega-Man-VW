extends Control

var player: Player
var weapons_buttons =  Array([], TYPE_OBJECT, &"Button", null)
var energy_bars =  Array([], TYPE_OBJECT, &"TextureProgressBar", null)

@onready var bar_health = $MarginContainer/VSplitContainer/HSplitContainer/VBoxContainer/HealthBar
@onready var extra_life_number = $MarginContainer/VSplitContainer/HSplitContainer/VBoxContainer/ExtraLifeNumber

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	player = get_parent().get_parent()
	
	weapons_buttons.resize(9)
	weapons_buttons[0] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn1/Weapon0/Button
	weapons_buttons[1] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn1/Weapon1/Button
	weapons_buttons[2] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn1/Weapon2/Button
	weapons_buttons[3] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn1/Weapon3/Button
	weapons_buttons[4] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn1/Weapon4/Button
	weapons_buttons[5] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn2/Weapon5/Button
	weapons_buttons[6] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn2/Weapon6/Button
	weapons_buttons[7] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn2/Weapon7/Button
	weapons_buttons[8] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn2/Weapon8/Button
	energy_bars.resize(9)
	energy_bars[0] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn1/Weapon0/WeaponBar
	energy_bars[1] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn1/Weapon1/WeaponBar
	energy_bars[2] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn1/Weapon2/WeaponBar
	energy_bars[3] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn1/Weapon3/WeaponBar
	energy_bars[4] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn1/Weapon4/WeaponBar
	energy_bars[5] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn2/Weapon5/WeaponBar
	energy_bars[6] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn2/Weapon6/WeaponBar
	energy_bars[7] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn2/Weapon7/WeaponBar
	energy_bars[8] = $MarginContainer/VSplitContainer/HBoxContainer/WeaponColumn2/Weapon8/WeaponBar


func _input(event : InputEvent):
	if(event.is_action_pressed("pause") and Global.can_pause):
		if get_tree().paused:
			unpause()
		else:
			pause()

func pause():
	show()
	get_tree().paused = true
	
	# Set focus
	match player.shooting_controller.curr_weapon:
		Global.Weapon.mega_buster:
			weapons_buttons[0].grab_focus()
		Global.Weapon.bowser_fire:
			weapons_buttons[1].grab_focus()
	
	var energies = player.shooting_controller.get_energies()
	for n in energies.size():
		if !energies[n]: #is null
			weapons_buttons[n].disabled = true
			energy_bars[n].value = 0
		else:
			energy_bars[n].value = energies[n]
	
	bar_health.value = player.health.curr_health
	extra_life_number.text = str(Global.num_of_lives)

func unpause():
	hide()
	get_tree().paused = false



#func _on_button_resume_pressed():
#	unpause()


func _on_exit_button_pressed():
	unpause()
	Global.can_pause = false
	Global.goto_scene(Global.Level.stage_select)




func _on_button0_pressed():
	if (player.shooting_controller.curr_weapon != Global.Weapon.mega_buster):
		# get_tree().get_nodes_in_group("shots").clear() not clear but queue_free() all nodes
		player.shooting_controller.switch_weapons(Global.Weapon.mega_buster)
		# change color
	
	unpause()

func _on_button1_pressed():
	if (player.shooting_controller.curr_weapon != Global.Weapon.bowser_fire):
		# get_tree().get_nodes_in_group("shots").clear() not clear but queue_free() all nodes
		player.shooting_controller.switch_weapons(Global.Weapon.bowser_fire)
		# change color
	
	unpause()

func _on_button2_pressed():
	pass # Replace with function body.

func _on_button3_pressed():
	pass # Replace with function body.

func _on_button4_pressed():
	pass # Replace with function body.

func _on_button5_pressed():
	pass # Replace with function body.

func _on_button6_pressed():
	pass # Replace with function body.

func _on_button7_pressed():
	pass # Replace with function body.

func _on_button8_pressed():
	pass # Replace with function body.
