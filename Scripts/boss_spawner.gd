class_name BossSpawner
extends Node2D

@export var boss : Resource
var b

func spawn_boss() -> void:
	b = boss.instantiate()
	add_child(b)
	b.health.health = 0
	b.state_machine.intro()
