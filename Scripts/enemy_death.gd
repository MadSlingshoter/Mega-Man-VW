extends AnimatedSprite2D
## AnimatedSprite2D for the explosion for an enemy's death.

## Callback for to remove the node after the animation is finished.
func _on_animation_finished():
	queue_free()
