extends TextureProgressBar



func _on_shooting_controller_energy_updated(new_energy):
	if new_energy < 0:
		value = 0
		hide()
	else:
		value = new_energy
		show()


func _on_player_energy_bar_color_changed(new_color1, new_color2):
	material.set("shader_param/new_color1", new_color1)
	material.set("shader_param/new_color2", new_color2)
