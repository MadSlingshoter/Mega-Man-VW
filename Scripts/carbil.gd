extends CharacterBody2D
## Class for the Carbil enemy.
##
## Enemy that continually spawns off screen and drives forward.

## The movement speed of the enemy
@export var speed = 150.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

## The AnimatedSprite2D for the animations.
@onready var animations = $Animations
## The node for the death explosion.
@onready var enemy_death = $EnemyDeathComponent
## The node for random drops on death.
@onready var item_drop = $ItemDropComponent
## RayCast2D for detecting walls in front.
@onready var ray_cast = $RayCast2D

# Plays the starting animation.
func _ready():
	animations.play("drive")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Always drives to the left.
	velocity.x = -speed
	
	# Remove enemy if collide with wall.
	if ray_cast.is_colliding():
		enemy_death.death()
		queue_free()
	
	move_and_slide()

# Callback for when killed, chance for an item drop, explosion, and removed.
func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()

# Callback for when not on screen, removed.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
