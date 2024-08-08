class_name PickupAnimation
extends AnimatedSprite2D

@onready var effects_animation_player = $EffectsAnimationPlayer

func flash():
	effects_animation_player.play("flash")
