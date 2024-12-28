extends Node2D
class_name Health
## Handles the logic for the characters' health.

## Signals that the character's health has been damage and what the new current health is.
signal health_damaged(curr_health)
## Signals that the character's health has been healed and what the new current health is.
signal health_healed(curr_health)
## Signals that the character has run out of health.
signal killed()
## Signals that the character's invulnerability after getting hit has run out.
signal invul_over()

## Whether or not the character has invulnerability after being hit. For the player and bosses.
@export var HAS_INVULNERABILITY : bool = false
## For how long the invulnerability lasts.
@export var INVULNERABILITY_LENGTH : float = 1.0
## The max health of the character. 28 for the player and bosses.
@export var MAX_HEALTH : int = 3
## If the character is the player.
@export var IS_PLAYER : bool = false

## The current health of the character.
var curr_health : int
## If the character can take damage or get healed. For room transitions and cutscenes.
var can_interact : bool = true

## The Timer for the invulnerability duration.
@onready var invul_timer = $InvulnerabilityTimer

func _ready():
	curr_health = MAX_HEALTH
	invul_timer.wait_time = INVULNERABILITY_LENGTH

## Called to apply damage to the character. The bool return is mainly used for attacks that are
## destroyed only if the enemy is not killed.
func damage(value) -> bool:
	# Take no damage during invulnerability or room transitions and cutscenes.
	if invul_timer.is_stopped() and can_interact:
		var prev_health = curr_health
		curr_health = clamp(curr_health - value, 0, MAX_HEALTH)
		# add signal if damage value is 0?
		# If damage is taken
		if curr_health != prev_health:
			if not IS_PLAYER:
				AudioManager.play_enemy_hurt_sound()
			emit_signal("health_damaged", curr_health)
			if HAS_INVULNERABILITY:
				invul_timer.start()
			# If lose all health.
			if curr_health <= 0:
				emit_signal("killed")
			return true
	return false

## Called to apply damage to the character that ignores invulnerability.
func pierce_damage(value) -> bool:
	# Take no damage during room transitions and cutscenes.
	if can_interact:
		var prev_health = curr_health
		curr_health = clamp(curr_health - value, 0, MAX_HEALTH)
		
		if curr_health != prev_health:
			if not IS_PLAYER:
				AudioManager.play_enemy_hurt_sound()
			emit_signal("health_damaged", curr_health)
			# If lose all health.
			if curr_health <= 0:
				emit_signal("killed")
				return true
	return false

## Called to apply healing to the character.
func heal(value):
	# Cannot be healed during room transitions and cutscenes.
	if can_interact:
		var prev_health = curr_health
		curr_health = clamp(curr_health + value, 0, MAX_HEALTH)
		
		if curr_health != prev_health:
			if IS_PLAYER:
				AudioManager.play_recover_sound()
			emit_signal("health_healed", curr_health)

## Send a signal when the invulnerability has run out to stops the flashing of the character.
func _on_invulnerability_timer_timeout():
	emit_signal("invul_over")
