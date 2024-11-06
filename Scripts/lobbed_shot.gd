extends EnemyWeapon

var time = 0.0

var speed = Vector2(90, -100)
var acceleration_y = 850 #default gravity for project is 750



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time > 0:
		if !visible_on_screen_notifier.is_on_screen():
			queue_free()
	time += delta
	
	speed.y += acceleration_y * delta
	position.x += speed.x * direction * delta
	position.y += speed.y * delta
	
	if is_contacting:
		playerHurtBox.damage(attack)


func _on_area_entered(area):
	if area is Hurtbox:
		playerHurtBox = area
		is_contacting = true


func _on_area_exited(area):
	if area is Hurtbox:
		playerHurtBox = null
		is_contacting = false
