extends CharacterBody2D
## Class for the Batton basic enemy.
##
## This class handles the logic for the Batton basic enemy.
## The enemy waits until hit or until the player gets close enough. Then the enemy flies towards
## the player. When the player is hit, the enemy flies straight up for a short while.

## The different states the enemy can be in.
enum State {
	IDLE, ## Waiting
	START_FLY, ## Transitioning from IDLE to FLY
	FLY, ## Moving towards the player
	AFTER_HIT, ## Flying away from player after hitting them
}

## The movement speed of the enemy
@export var _speed :float 

## The current state of the enemy. Starts in IDLE state.
var _state = State.IDLE 

## The AnimatedSprite2D for the enemy.
@onready var animations = $Animations
## The Contact Box component for the enemy.
@onready var contact_box = $ContactBox 
## The node for the death explosion.
@onready var enemy_death = $EnemyDeathComponent 
## The node for random drops on death.
@onready var item_drop = $ItemDropComponent 
## Timer for the length of the AFTER_HIT state.
@onready var after_hit_timer = $AfterHitTimer 

# Starts with the "idle" animation because in the IDLE state.
func _ready():
	animations.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
# If in FLY state, move towards the player at a constant speed. If make contact with player, then 
# enter AFTER_HIT state.
# Else if in AFTER_HIT state, fly straight up.
func _process(delta):
	if _state == State.FLY:
		var player_pos = Global.player.global_position
		var direction = (player_pos - global_position).normalized()
		velocity = direction * _speed
		if contact_box.is_contacting:
			_state = State.AFTER_HIT
			after_hit_timer.start()
	elif _state == State.AFTER_HIT:
		velocity = Vector2(0, -1) * (_speed + 5)
	
	move_and_slide()

# Callback for when killed, chance for an item drop, explosion, and removed.
func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()

# Callback for when not on screen, removed.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Callback for when a player has entered the PlayerDetector area, starts flying.
func _on_player_detector_player_detected():
	_start_flying()

# Callback for when taking damage, starts flying.
func _on_health_health_damaged(curr_health):
	_start_flying()

## If in the IDLE state, then start flying. Stay in the START_FLY state until the animation is finished.
func _start_flying():
	if _state == State.IDLE:
		_state = State.START_FLY
		animations.play("start_fly")
		animations.animation_finished.connect(_on_start_fly_finished)

# Callback for when the "start_fly" animation is finished. Enter the FLY state.
func _on_start_fly_finished():
	animations.animation_finished.disconnect(_on_start_fly_finished)
	_state = State.FLY
	animations.play("fly")

# Callback for when the after hit timer runs out to return to the FLY state.
func _on_after_hit_timer_timeout():
	_state = State.FLY




