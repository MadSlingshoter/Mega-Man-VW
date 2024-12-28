extends StaticBody2D
## The Fire Bar enemy obstacle.
##
## Stays in place with a spinning bar of fireballs. Cannot be damaged.

## If true, spins in a clockwise direction.
## If false, spins in a counterclockwise direction.
@export var clockwise_rotation: bool = false

## The speed of the spin.
var _rotation_speed: float = 1
## The direction of the spin. Determined by clockwise_rotation.
var _direction = -1

## The AnimatedSprite2D for the animations.
@onready var animations = $Animations
## The Contact Box component for the enemy.
@onready var contact_box = $ContactBox

# Sets the rotation direction.
func _ready():
	animations.play("fire_spin")
	if clockwise_rotation:
		_direction = 1

# Rotates the animations and the Contact Box in unison.
func _process(delta):
	animations.rotate(_rotation_speed * _direction * delta)
	contact_box.rotate(_rotation_speed * _direction * delta)
