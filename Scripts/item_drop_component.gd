extends Node

@export var item_pickup : Resource
@export var parent : CharacterBody2D

@export var small_health_weight : int
@export var big_health_weight : int
@export var small_energy_weight : int
@export var big_energy_weight : int
@export var extra_life_weight : int

const TOTAL_WEIGHT = 128

var pickup_type: Global.Pickup

func drop_pickup():
	var drop_chance = randi_range(1, TOTAL_WEIGHT)
	var accumulated_weight = small_health_weight
	if drop_chance <= accumulated_weight:
		pickup_type = Global.Pickup.small_health
		spawn_pickup()
		return
	
	accumulated_weight += big_health_weight
	if drop_chance <= accumulated_weight:
		pickup_type = Global.Pickup.big_health
		spawn_pickup()
		return
	
	accumulated_weight += small_energy_weight
	if drop_chance <= accumulated_weight:
		pickup_type = Global.Pickup.small_energy
		spawn_pickup()
		return
	
	accumulated_weight += big_energy_weight
	if drop_chance <= accumulated_weight:
		pickup_type = Global.Pickup.big_energy
		spawn_pickup()
		return
	
	accumulated_weight += extra_life_weight
	if drop_chance <= accumulated_weight:
		pickup_type = Global.Pickup.extra_life
		spawn_pickup()
		return

func spawn_pickup():
	var spawned_pickup = item_pickup.instantiate()
	parent.get_parent().get_parent().call_deferred("add_child", spawned_pickup)
	spawned_pickup.call_deferred("set_random_drop", pickup_type)
	spawned_pickup.set_deferred("global_position", parent.global_position) 
