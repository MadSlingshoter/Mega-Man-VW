# OLD AND DOES NOT WORK
# DO NOT USE
# ONLY HERE BECAUSE MAYBE USE SOME OLD CODE

extends CharacterBody2D

@export var MAX_HEALTH = 2
@export var CONTACT_DAMAGE = 20
@onready var health = MAX_HEALTH : set = _set_health
@export var START_DIRECTION_LEFT = true
@export var SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = -1

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_down = $RayCast2DDown
@onready var ray_cast_side = $RayCast2DSide

func _ready():
	if !START_DIRECTION_LEFT:
		direction *= -1
		scale.x = -scale.x

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Walk back and forth
	move_character()
	detect_turn_around()
	
	update_ground_animation()
	move_and_slide()

func init(left):
	if not left:
		turn_around()

func update_ground_animation():
	if velocity.x != 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

func move_character():
	velocity.x = SPEED * direction

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

func detect_turn_around():
	if (not ray_cast_down.is_colliding() or ray_cast_side.is_colliding()) and is_on_floor():
		turn_around()

func turn_around():
	direction *= -1
	scale.x = -scale.x

func _on_area_2d_area_entered(area):
	area.get_parent().damage(CONTACT_DAMAGE)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
