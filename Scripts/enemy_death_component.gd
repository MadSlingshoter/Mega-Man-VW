extends Node2D
## Adds the explosion when the enemy dies.

## The explosion node.
@onready var enemy_death = preload("res://Characters/Death/enemy_death.tscn")

## Adds the death explosion to the current scene.
## Cannot be added to the enemy itself as it is removed from the scene.
func death():
	var death_explosion = enemy_death.instantiate()
	get_parent().get_parent().add_child(death_explosion)
	death_explosion.global_position = global_position
