extends CharacterBody2D

#signal health_updated(health)
#signal killed()

@export var MAX_HEALTH = 3
@export var CONTACT_DAMAGE = 3
@onready var health = MAX_HEALTH : set = _set_health
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

func damage(amount):
	_set_health(health - amount)

func kill():
	queue_free()

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, MAX_HEALTH)
	if health != prev_health:
		#emit_signal("health_updated", health)
		if health == 0:
			kill()
			#emit_signal("killed")

func _on_area_2d_area_entered(area):
	area.get_parent().damage(CONTACT_DAMAGE)
