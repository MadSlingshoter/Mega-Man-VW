extends Area2D
## Area2D for enemies that detects a player within it.

## Signals that a player has entered the area.
signal player_detected()
## Signals that a player has exitted the area.
signal player_lost()

## Bool for whether a player is currently in the area.
var player_in_area: bool = false

## Callback for when a player enters the area.
func _on_area_entered(area):
	if area is Hurtbox:
		player_in_area = true
		emit_signal("player_detected")

## Callback for when a player exits the area.
func _on_area_exited(area):
	if area is Hurtbox:
		player_in_area = false
		emit_signal("player_lost")
