extends Area2D
class_name Hurtbox
## Handles the logic for the characters' hurtbox, the part that can take damage.

## Signals that the character has been hit by an attack.
signal damage_taken(attack : Attack)
## Signals that the character has been hit by a invulnerability piercing attack.
signal pierce_damage_taken(attack : Attack)

## The character's Health node.
@export var health : Health
## Will override the normal damage for Mega Buster, if the value greater than -1.
@export var mega_buster_override: int = -1
## Will override the normal damage for Bowser Fire, if the value greater than -1.
@export var bowser_fire_override: int = -1
## Will override the normal damage for Car Wheel, if the value greater than -1.
@export var car_wheel_override: int = -1
## Will override the normal damage for Construction Bomb, if the value greater than -1.
@export var construction_bomb_override: int = -1
## Will override the normal damage for Waffle Missile, if the value greater than -1.
@export var waffle_missile_override: int = -1
## Will override the normal damage for Police Shock, if the value greater than -1.
@export var police_shock_override: int = -1
## Will override the normal damage for Lego Shield, if the value greater than -1.
@export var lego_shield_override: int = -1
## Will override the normal damage for Cat Scratch, if the value greater than -1.
@export var cat_scratch_override: int = -1
## Will override the normal damage for Gold Tornado, if the value greater than -1.
@export var gold_tornado_override: int = -1

## Called by attacks to deal damage to the character. Will apply the damage override if applicable.
## Will call the Health node's damage function. The bool return is mainly used for attacks that are
## destroyed only if the enemy is not killed.
func damage(attack : Attack) -> bool:
	if attack.attack_type == Global.Weapon.MEGA_BUSTER and mega_buster_override > -1:
		attack.damage = mega_buster_override
	if attack.attack_type == Global.Weapon.BOWSER_FIRE and bowser_fire_override > -1:
		attack.damage = bowser_fire_override
	if attack.attack_type == Global.Weapon.CAR_WHEEL and car_wheel_override > -1:
		attack.damage = car_wheel_override
	if attack.attack_type == Global.Weapon.CONSTRUCTION_BOMB and construction_bomb_override > -1:
		attack.damage = construction_bomb_override
	if attack.attack_type == Global.Weapon.WAFFLE_MISSILE and waffle_missile_override > -1:
		attack.damage = waffle_missile_override
	if attack.attack_type == Global.Weapon.POLICE_SHOCK and police_shock_override > -1:
		attack.damage = police_shock_override
	if attack.attack_type == Global.Weapon.LEGO_SHIELD and lego_shield_override > -1:
		attack.damage = lego_shield_override
	if attack.attack_type == Global.Weapon.CAT_SCRATCH and cat_scratch_override > -1:
		attack.damage = cat_scratch_override
	if attack.attack_type == Global.Weapon.GOLD_TORNADO and gold_tornado_override > -1:
		attack.damage = gold_tornado_override
	emit_signal("damage_taken", attack)
	return health.damage(attack.damage)

## Called by attacks to deal damage through invulnerability. Calls the Health node's pierce_damage
## function.
func pierce_damage(attack : Attack) -> bool:
	emit_signal("damage_taken", attack)
	return health.pierce_damage(attack.damage)
	
