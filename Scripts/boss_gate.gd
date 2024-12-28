class_name BossGate
extends StaticBody2D
## Gates that close off a boss room.

## AnimatedSprite2D for the animations
@onready var animations = $Animations
## The CollisionShape2D for the gate
@onready var collision_shape = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
# Gate starts off being closed.
func _ready():
	animations.play("closed")

## Opens the gate. Plays the animation and removes the collision shape, allowing the player to
## pass through.
func open():
	animations.play("open")
	collision_shape.set_deferred("disabled", true)
	AudioManager.play_gate_sound()

## Closes the gate. Plays the animation and adds the collision shape, disallowing the player to
## pass through.
func close():
	animations.play("close")
	collision_shape.set_deferred("disabled", false)
	AudioManager.play_gate_sound()
