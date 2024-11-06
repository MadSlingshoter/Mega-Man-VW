extends Node2D
class_name Health

signal health_damaged(curr_health)
signal health_healed(curr_health)
signal killed()
signal invul_over()

@onready var invul_timer = $InvulnerabilityTimer

@export var HAS_INVULNERABILITY : bool = false
@export var INVULNERABILITY_LENGTH : float = 1.0
@export var MAX_HEALTH : int = 3
@export var IS_PLAYER : bool = false
var curr_health : int
var can_interact : bool = true

func _ready():
	curr_health = MAX_HEALTH
	invul_timer.wait_time = INVULNERABILITY_LENGTH

# the bool is used for attacks that are destroyed only if the enemy is not killed
func damage(value) -> bool:
	if invul_timer.is_stopped() and can_interact:
		var prev_health = curr_health
		curr_health = clamp(curr_health - value, 0, MAX_HEALTH)
		# add signal if damage value is 0
		if curr_health != prev_health:
			if not IS_PLAYER:
				AudioManager.play_enemy_hurt_sound()
			emit_signal("health_damaged", curr_health)
			if HAS_INVULNERABILITY:
				invul_timer.start()
			if curr_health <= 0:
				emit_signal("killed")
			return true
	return false

#ignores invulnerability
func pierce_damage(value) -> bool:
	if can_interact:
		var prev_health = curr_health
		curr_health = clamp(curr_health - value, 0, MAX_HEALTH)
		
		if curr_health != prev_health:
			if not IS_PLAYER:
				AudioManager.play_enemy_hurt_sound()
			emit_signal("health_damaged", curr_health)
			if curr_health <= 0:
				emit_signal("killed")
				return true
	return false

func heal(value):
	if can_interact:
		var prev_health = curr_health
		curr_health = clamp(curr_health + value, 0, MAX_HEALTH)
		
		if curr_health != prev_health:
			if IS_PLAYER:
				AudioManager.play_recover_sound()
			emit_signal("health_healed", curr_health)


func _on_invulnerability_timer_timeout():
	emit_signal("invul_over")
