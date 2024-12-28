extends Node
## Handles item drops of normal enemies and the drop rate.

## The maximum total weight.
const TOTAL_WEIGHT = 128

## The item object.
@export var item_pickup : Resource
## The enemy.
@export var parent : CharacterBody2D
## The weight of the small health drop.
@export var small_health_weight : int
## The weight of the big health drop.
@export var big_health_weight : int
## The weight of the small energy drop.
@export var small_energy_weight : int
## The weight of the big energy drop.
@export var big_energy_weight : int
## The weight of the extra life drop.
@export var extra_life_weight : int
# The tanks are in the item_pickup object, but do not drop from enemies.

## The pickup item type
var _pickup_type: Global.Pickup

## Calculates if and which drop, and if so, calls the function to spawn it.
func drop_pickup():
	# Random integer
	var drop_chance = randi_range(1, TOTAL_WEIGHT)
	
	# Small health drop
	var accumulated_weight = small_health_weight
	if drop_chance <= accumulated_weight:
		_pickup_type = Global.Pickup.SMALL_HEALTH
		spawn_pickup()
		return
	
	# Big health drop
	accumulated_weight += big_health_weight
	if drop_chance <= accumulated_weight:
		_pickup_type = Global.Pickup.BIG_HEALTH
		spawn_pickup()
		return
	
	# Small energy drop
	accumulated_weight += small_energy_weight
	if drop_chance <= accumulated_weight:
		_pickup_type = Global.Pickup.SMALL_ENERGY
		spawn_pickup()
		return
	
	# Big energy drop
	accumulated_weight += big_energy_weight
	if drop_chance <= accumulated_weight:
		_pickup_type = Global.Pickup.BIG_ENERGY
		spawn_pickup()
		return
	
	# Extra life drop
	accumulated_weight += extra_life_weight
	if drop_chance <= accumulated_weight:
		_pickup_type = Global.Pickup.EXTRA_LIFE
		spawn_pickup()
		return

## Spawns the pickup at the node's location.
func spawn_pickup():
	var spawned_pickup = item_pickup.instantiate()
	parent.get_parent().get_parent().call_deferred("add_child", spawned_pickup)
	spawned_pickup.call_deferred("set_random_drop", _pickup_type)
	spawned_pickup.set_deferred("global_position", parent.global_position) 
