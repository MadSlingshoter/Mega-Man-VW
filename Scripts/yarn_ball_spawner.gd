extends Node2D

@export var yarn_ball : Resource

@onready var spawn_timer = $SpawnTimer

func _ready():
	spawn_timer.start()

func _on_spawn_timer_timeout():
	var b
	b = yarn_ball.instantiate()
	add_child(b)
