extends Weapon

@onready var collision_shape = $CollisionShape2D

const SPEED = 1.5
var time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# needed because is first drawn after the first check 
	if time > 0:
		if !visible_on_screen_notifier.is_on_screen():
			queue_free()
	time += delta
	
	if is_relected:
		# shots fly upwards diagonally backwards
		position.x -= direction*SPEED
		position.y -= SPEED
	else:
		position.x += direction*SPEED


func _on_area_entered(area):
	if area is ShieldBox:
		collision_shape.set_deferred("disabled", true)
		is_relected = true
	if area is Hurtbox:
		area.damage(attack)
		queue_free()
	
