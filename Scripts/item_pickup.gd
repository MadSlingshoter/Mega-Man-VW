class_name ItemPickup
extends CharacterBody2D

@export var type: Global.Pickup

@onready var flash_timer = $FlashTimer
@onready var despawn_timer = $DespawnTimer
@onready var animations = $AnimatedSprite2D
@onready var effects = $AnimatedSprite2D/EffectsAnimationPlayer
@onready var collision_big = $CollisionShapeBig
@onready var collision_small = $CollisionShapeSmall
@onready var pickup_area_big = $PickupBox/CollisionShapeBig
@onready var pickup_area_small = $PickupBox/CollisionShapeSmall

const small_value = 2
const big_value = 10

var value = 1
var permanent = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if type == Global.Pickup.random_drop:
		flash_timer.start()
		permanent = false
	else:
		set_up()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func set_random_drop(pickup_type: Global.Pickup):
	type = pickup_type
	set_up()

func set_up():
	match type:
		Global.Pickup.small_health:
			value = small_value
			animations.play("small_health")
			collision_small.set_deferred("disabled", false)
			pickup_area_small.set_deferred("disabled", false)
		Global.Pickup.big_health:
			value = big_value
			animations.play("big_health")
			collision_big.set_deferred("disabled", false)
			pickup_area_big.set_deferred("disabled", false)
		Global.Pickup.small_energy:
			value = small_value
			animations.play("small_energy")
			collision_small.set_deferred("disabled", false)
			pickup_area_small.set_deferred("disabled", false)
		Global.Pickup.big_energy:
			value = big_value
			animations.play("big_energy")
			collision_big.set_deferred("disabled", false)
			pickup_area_big.set_deferred("disabled", false)
		Global.Pickup.extra_life:
			animations.play("extra_life")
			collision_big.set_deferred("disabled", false)
			pickup_area_big.set_deferred("disabled", false)

func _on_flash_timer_timeout():
	effects.play("flash")
	despawn_timer.start()

func _on_despawn_timer_timeout():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	if not permanent:
		queue_free()
