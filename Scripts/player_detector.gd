extends Area2D

signal player_detected()
signal player_lost()

var player_in_area: bool = false

func _on_area_entered(area):
	if area is Hurtbox:
		player_in_area = true
		emit_signal("player_detected")


func _on_area_exited(area):
	if area is Hurtbox:
		player_in_area = false
		emit_signal("player_lost")
