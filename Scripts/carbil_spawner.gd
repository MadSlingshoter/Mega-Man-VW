extends Area2D

@export var carbil : Resource
var spawn_rate : float = 3

var player_in_area: bool = false

@onready var spawn_timer = $SpawnTimer

func _on_area_entered(area):
	if area is RoomDetector:
		player_in_area = true
		spawn_timer.start(0.8)

func _on_area_exited(area):
	if area is RoomDetector:
		player_in_area = false
		spawn_timer.stop()

func _on_spawn_timer_timeout():
	if player_in_area:
		var c = carbil.instantiate()
		add_child(c)
		c.global_position.x = Global.player.global_position.x + 150
		c.global_position.y = 180
		
		AudioManager.play_honk_sound()
		spawn_timer.start(spawn_rate)



