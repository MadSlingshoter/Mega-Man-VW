extends Node2D

@export var enemy : Resource
var e

func _on_visible_on_screen_notifier_2d_screen_entered():
	if not is_instance_valid(e):
		e = enemy.instantiate()
		add_child(e)
		e.add_to_group("enemies")
