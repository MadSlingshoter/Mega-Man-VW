extends EnemyWeapon

@onready var animations = $Animations
@onready var raycast_down = $RayCastDown
@onready var raycast_front = $RayCastFront

const SPEED_HORI_DOWN: float = 70
const SPEED_HORI_FORWARD: float = 100
const SPEED_VERT: float = 70

var time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# needed because is first drawn after the first check 
	if time > 0:
		if !visible_on_screen_notifier.is_on_screen():
			queue_free()
	time += delta
	
	if raycast_front.is_colliding():
		queue_free()
	
	if not raycast_down.is_colliding():
		animations.play("down")
		position.x += direction * SPEED_HORI_DOWN * delta
		position.y += SPEED_VERT * delta
	else:
		animations.play("forward")
		position.x += direction * SPEED_HORI_FORWARD * delta
	
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
