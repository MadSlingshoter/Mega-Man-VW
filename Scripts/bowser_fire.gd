extends Weapon

@onready var collision_shape = $CollisionShape2D

const SPEED = 160
var time = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# needed because is first drawn after the first check 
	if time > 0:
		if !visible_on_screen_notifier.is_on_screen():
			queue_free()
	time += delta
	
	position.x += direction * SPEED * delta


func _on_area_entered(area):
	if area is ShieldBox:
		queue_free()
	if area is Hurtbox:
		if not area.damage(attack):
			queue_free()
