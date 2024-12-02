extends Area2D
class_name Hurtbox

signal damage_taken(attack : Attack)
signal pierce_damage_taken(attack : Attack)

@export var health : Health
# if these values are not less than 0, they will override the normal damage from the weapons
@export var mega_buster_override: int = -1
@export var bowser_fire_override: int = -1
@export var car_wheel_override: int = -1
@export var construction_bomb_override: int = -1
@export var waffle_missile_override: int = -1
@export var police_shock_override: int = -1
@export var lego_shield_override: int = -1
@export var cat_scratch_override: int = -1
@export var gold_tornado_override: int = -1

# the bool is used for attacks that are destroyed only if the enemy is not killed
func damage(attack : Attack) -> bool:
	if attack.attack_type == Global.Weapon.mega_buster and mega_buster_override > -1:
		attack.damage = mega_buster_override
	if attack.attack_type == Global.Weapon.bowser_fire and bowser_fire_override > -1:
		attack.damage = bowser_fire_override
	if attack.attack_type == Global.Weapon.car_wheel and car_wheel_override > -1:
		attack.damage = car_wheel_override
	if attack.attack_type == Global.Weapon.constuction_bomb and construction_bomb_override > -1:
		attack.damage = construction_bomb_override
	if attack.attack_type == Global.Weapon.waffle_missile and waffle_missile_override > -1:
		attack.damage = waffle_missile_override
	if attack.attack_type == Global.Weapon.police_shock and police_shock_override > -1:
		attack.damage = police_shock_override
	if attack.attack_type == Global.Weapon.lego_shield and lego_shield_override > -1:
		attack.damage = lego_shield_override
	if attack.attack_type == Global.Weapon.cat_scratch and cat_scratch_override > -1:
		attack.damage = cat_scratch_override
	if attack.attack_type == Global.Weapon.gold_tornado and gold_tornado_override > -1:
		attack.damage = gold_tornado_override
	emit_signal("damage_taken", attack)
	return health.damage(attack.damage)

func pierce_damage(attack : Attack) -> bool:
	emit_signal("damage_taken", attack)
	return health.pierce_damage(attack.damage)
	
