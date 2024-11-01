extends EnemyWeapon

var time = 0.0
var vertical_direction: int = 0 # 0, -1, 1

const SPEED = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time > 0:
		if !visible_on_screen_notifier.is_on_screen():
			queue_free()
	time += delta
	
	var angle = Vector2(direction, vertical_direction).normalized()
	position += angle * SPEED * delta
	
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
