extends EnemyWeapon

var time = 0.0

var acceleration_y: float = 750
var speed: float = 0

@onready var enemy_death = $EnemyDeathComponent
@onready var raycast = $RayCast2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time > 0:
		if !visible_on_screen_notifier.is_on_screen():
			queue_free()
	time += delta
	
	if is_contacting:
		if playerHurtBox.damage(attack):
			enemy_death.death()
			queue_free()
	
	if raycast.is_colliding():
		enemy_death.death()
		queue_free()
	
	speed += acceleration_y * delta
	position.y += speed * delta
	
	


func _on_area_entered(area):
	if area is Hurtbox:
		playerHurtBox = area
		is_contacting = true


func _on_area_exited(area):
	if area is Hurtbox:
		playerHurtBox = null
		is_contacting = false
