extends Node2D
class_name Health

signal health_damaged(health)
signal health_healed(health)
signal killed()
signal invul_over()

@onready var invul_timer = $InvulnerabilityTimer

@export var HAS_INVULNERABILITY : bool = false
@export var INVULNERABILITY_LENGTH : float = 1.0
@export var MAX_HEALTH : int = 3
var health : int
var can_interact : bool = true

func _ready():
	health = MAX_HEALTH
	invul_timer.wait_time = INVULNERABILITY_LENGTH

# the bool is used for attacks that are destroyed only if the enemy is not killed
func damage(value) -> bool:
	if invul_timer.is_stopped() and can_interact:
		var prev_health = health
		health = clamp(health - value, 0, MAX_HEALTH)
		
		if health != prev_health:
			emit_signal("health_damaged", health)
			if HAS_INVULNERABILITY:
				invul_timer.start()
			if health <= 0:
				emit_signal("killed")
				return true
	return false

#ignores invulnerability
func pierce_damage(value) -> bool:
	if can_interact:
		var prev_health = health
		health = clamp(health - value, 0, MAX_HEALTH)
		
		if health != prev_health:
			emit_signal("health_damaged", health)
			if health <= 0:
				emit_signal("killed")
				return true
	return false

func heal(value):
	if can_interact:
		var prev_health = health
		health = clamp(health - value, 0, MAX_HEALTH)
		
		if health != prev_health:
			emit_signal("health_healed", health)


func _on_invulnerability_timer_timeout():
	emit_signal("invul_over")
