extends Node2D

@onready var enemy = preload("res://Characters/metool.tscn")
@export var START_DIRECTION_LEFT = true 
var e
const MAX_NUM_OF_ENEMIES = 3 # don't really need this

func _on_visible_on_screen_notifier_2d_screen_entered():
	# Spawn enemy
	if not is_instance_valid(e) and get_tree().get_nodes_in_group("num_of_enemies").size() <= MAX_NUM_OF_ENEMIES:
		e = enemy.instantiate()
		e.init(START_DIRECTION_LEFT)
		add_child(e)
		e.add_to_group("num_of_enemies")
