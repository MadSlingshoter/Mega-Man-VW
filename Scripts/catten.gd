extends CharacterBody2D
## Class for the Catten enemy.
##
## Walks back and forth with a short delay between. Stops at edges and walls or after a certain 
## distance.

## The different states the enemy can be in.
enum State {
	IDLE, ## Waiting
	WALK, ## Walking 
}

## The movement speed of the enemy.
@export var SPEED :float

## The current state the enemy is in. Starts in IDLE.
var state = State.IDLE
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
## The direction the enemy is facing with 1 being right and -1 being left
var direction = 1

## The AnimatedSprite2D for the animations.
@onready var animations = $Animations
## The Contact Box component for the enemy.
@onready var contact_box = $ContactBox
## The node for the death explosion.
@onready var enemy_death = $EnemyDeathComponent
## The node for random drops on death.
@onready var item_drop = $ItemDropComponent
## Timer for the length of the wait in the IDLE state.
@onready var idle_timer = $IdleTimer
## Timer for the length of the WALK state.
@onready var walk_timer = $WalkTimer
## RayCast2D for detecting walls in front.
@onready var raycast_side = $RayCastSide
## RayCast2D for detecting platform edges.
@onready var raycast_down = $RayCastDown

# Starts facing away from the player.
func _ready():
	if Global.player.global_position.x > global_position.x:
		turn_around()
	idle_timer.start()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Plays the animations for the respective states.
	if state == State.IDLE:
		animations.play("idle")
	elif state == State.WALK:
		animations.play("walk")
		velocity.x = SPEED * direction
		# Stops walking on collision with a wall or at a platform edge.
		if raycast_side.is_colliding() or not raycast_down.is_colliding():
			stop_walk()
	
	move_and_slide()

## Changes the facing direction of the enemy.
func turn_around():
	direction *= -1
	scale.x = -scale.x

## Stops walking and changes to the IDLE state.
func stop_walk():
	velocity.x = 0
	state = State.IDLE
	idle_timer.start()

## Callback to turn around and change to the WALK state.
func _on_idle_timer_timeout():
	turn_around()
	state = State.WALK
	walk_timer.start()

## Callback to stop walking
func _on_walk_timer_timeout():
	stop_walk()

# Callback for when not on screen, removed.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Callback for when killed, chance for an item drop, explosion, and removed.
func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()


