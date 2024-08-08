extends Node2D

@onready var enemy_death = preload("res://Characters/Death/enemy_death.tscn")


func death():
	var death_explosion = enemy_death.instantiate()
	get_parent().get_parent().add_child(death_explosion)
	death_explosion.global_position = global_position
