extends Node2D

@onready var enemy = preload("res://Characters/Enemies/goomba.tscn")
var e

func _on_visible_on_screen_notifier_2d_screen_entered():
	if not is_instance_valid(e):
		e = enemy.instantiate()
		add_child(e)
