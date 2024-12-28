extends CharacterBody2D
## Class for the goomba enemy.
##
## Classic goomba from Super Mario Bros. Walks slowly. Turns around if it touches a wall.
## Unlike Mario games, cannot damage it by jumping on it.

## The movement speed of the enemy.
@export var speed :float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
## The direction the enemy is facing with 1 being right and -1 being left
var direction = 1

## The AnimatedSprite2D for the animations.
@onready var animations = $Animations
## RayCast2D for detecting walls in front.
@onready var raycast_side = $RayCastSide
## The node for the death explosion.
@onready var enemy_death = $EnemyDeathComponent
## The node for random drops on death.
@onready var item_drop = $ItemDropComponent

# Turn the enemy to move in the player's direction.
func _ready():
	if Global.player.global_position.x < global_position.x:
		turn_around()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_character()
	detect_turn_around()
	animations.play("walk")
	
	move_and_slide()

## Moves the enemy at a constant speed in the current direction.
func move_character():
	velocity.x = speed * direction

## Turns around the enemy if it collides with a wall.
func detect_turn_around():
	if raycast_side.is_colliding():
		turn_around()

## Changes the facing direction of the enemy.
func turn_around():
	direction *= -1
	scale.x = -scale.x

# Callback for when killed, chance for an item drop, explosion, and removed.
func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()

# Callback for when not on screen, removed.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
