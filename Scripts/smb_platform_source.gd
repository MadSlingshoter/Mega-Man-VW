extends Node2D

@onready var platform = preload("res://Levels/Platforms/smb_platform.tscn")

@export var direction = 1
var p


func _on_spawn_timer_timeout():
	p = platform.instantiate()
	p.init(direction)
	add_child(p)
	p.global_position = global_position
	p.start_move()
