extends TextureProgressBar



func _on_shooting_controller_energy_updated(new_energy):
	if new_energy < 0:
		value = 0
		hide()
	else:
		value = new_energy
		show()


# change color based on the equipped weapon and visibility
