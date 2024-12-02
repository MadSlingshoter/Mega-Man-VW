extends Weapon

var time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# needed because is first drawn after the first check 
	if time > 0:
		if !visible_on_screen_notifier.is_on_screen():
			queue_free()
	time += delta


func _on_area_entered(area):
	if area is ShieldBox:
		AudioManager.play_relected_sound()
	if area is Hurtbox:
		area.damage(attack)


func _on_animations_animation_finished():
	queue_free()
