extends Area2D
class_name Hurtbox

signal damage_taken(attack : Attack)
signal pierce_damage_taken(attack : Attack)

@export var health : Health
# if these values are not -1, they will override the normal damage from the weapons
@export var mega_buster_override: int = -1
@export var bowser_fire_override: int = -1

# the bool is used for attacks that are destroyed only if the enemy is not killed
func damage(attack : Attack) -> bool:
	if attack.attack_type == Global.Weapon.mega_buster and mega_buster_override != -1:
		attack.damage = mega_buster_override
	if attack.attack_type == Global.Weapon.bowser_fire and bowser_fire_override != -1:
		attack.damage = bowser_fire_override
	emit_signal("damage_taken", attack)
	return health.damage(attack.damage)

func pierce_damage(attack : Attack) -> bool:
	emit_signal("damage_taken", attack)
	return health.pierce_damage(attack.damage)
	
